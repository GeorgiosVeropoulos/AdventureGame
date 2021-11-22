using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System;

[RequireComponent(typeof(Camera))]
public class VMC : MonoBehaviour
{
    private LayerMask volumeLayer;
    private Shader compositeShader;
    private Shader renderFrontDepthShader;
    private Shader renderBackDepthShader;
    private Shader rayMarchShader;

    private bool increaseVisiblity = false, lod = false;

    private float opacity = 1.0f;
    private int volumeWidth = 256;
    private int volumeHeight = 256;
    private int volumeDepth = 256;
    private Vector4 clipDimensions = new Vector4(100, 100, 100, 0);

    private Material _rayMarchMaterial, _rayMarchMaterial2;
    private Material _compositeMaterial;
    private Camera _ppCamera;
    private Texture3D _volumeBuffer, _volumeBuffer2;
    private Texture2D tex;
    private Texture2D[] slices;
    int n, count = 1, level;
    private RenderTexture frontDepth, backDepth;
    string currentLOD = "", previousLOD = "";
    bool activeLOD = false, lod2group;
    List<string> getCurrentModels;
    List<Texture3D> volumeBufferArray;

    //Instantiate the shaders and generate the volumes
    void Start()
    {
        _rayMarchMaterial = new Material(Shader.Find("Hidden/Ray Marching/Ray Marching"));
        _compositeMaterial = new Material(Shader.Find("Hidden/Ray Marching/Composite"));
        renderFrontDepthShader = Shader.Find("Hidden/Ray Marching/Render Front Depth");
        renderBackDepthShader = Shader.Find("Hidden/Ray Marching/Render Back Depth");
        getCurrentModels = new List<string>();
        volumeBufferArray = new List<Texture3D>();
        volumeLayer = 1; //Default LayerMask
        n = PlayerPrefs.GetInt("CustomShots");
        slices = new Texture2D[n];

        if (GameObject.Find("LOD2Group"))
        {
            lod2group = true;
            GenerateVolumeTexture("texture", false, 2);
        }
        else
        {
            lod2group = false;
            GenerateVolumeTexture("texture", true, 1);
        }
    }

    //Get the actual LOD level and if it changes reload the slices on
    //the 3D texture on the shader 
    void Update()
    {
        if (!lod2group)
        {
            findLODGroup();
            if (activeLOD)
            {
                if (currentLOD == GameObject.FindGameObjectWithTag("model").name + "1")
                {
                    GenerateVolumeTexture("texture", false, 2);
                    Debug.Log("CurrentLOD1: " + currentLOD);
                    activeLOD = false;
                }
                if (currentLOD == GameObject.FindGameObjectWithTag("model").name + "2")
                {
                    GenerateVolumeTexture("texture21", false, 3);
                    Debug.Log("CurrentLOD2: " + currentLOD);
                    activeLOD = false;
                }
            }
        }
    }

    //Actual LOD Level on screen
    public void findLODGroup()
    {
        LODGroup lodGroup = new LODGroup();
        if (GameObject.Find("LOD2Group"))
            lodGroup = GameObject.Find("LOD2Group").GetComponent<LODGroup>();
        if (GameObject.Find("LOD3Group"))
            lodGroup = GameObject.Find("LOD3Group").GetComponent<LODGroup>();

        if (lodGroup != null)
        {
            Transform lodTransform = lodGroup.transform;
            foreach (Transform child in lodTransform)
            {
                if (child.GetComponent<Renderer>() != null && child.GetComponent<Renderer>().isVisible)
                {
                    previousLOD = child.name;
                    if (currentLOD != child.name)
                    {
                        activeLOD = true;
                        currentLOD = previousLOD;
                    }
                    else
                        activeLOD = false;
                }
            }
        }
    }

    //Load the slices on the 3D texture
    public void drawTexture(string txt, string lodSelected, int nLOD)
    {
        GameObject[] allObjects = FindObjectsOfType<GameObject>();
        string[] gameObjectNames = new string[allObjects.Length];
        string currentPath = "";
        byte[] fileData;
        n = PlayerPrefs.GetInt("CustomShots");
        slices = new Texture2D[n];

        //Get all the models in the scene
        for (int i = 0; i < allObjects.Length; i++)
        {
            gameObjectNames[i] = allObjects[i].name;
            if (Directory.Exists("Assets/Resources/Textures/" + gameObjectNames[i]))
            {
                currentPath = gameObjectNames[i];
                getCurrentModels.Add(currentPath);
            }
        }
        for (int i = 0; i < getCurrentModels.Count; i++)
        {
            //Create object with texture size
            for (int j = 0; j < n; j++)
            {
                //Set textures
                string filePath = "";
                string id = "1";

                GameObject itemTexture = findChildrenLODGroup("LOD" + lodSelected + "Group", getCurrentModels[i] + count);

                //Load textures to the correct model
                if (getCurrentModels[i] == GameObject.FindGameObjectWithTag("model").name)
                {
                    filePath = "Assets/Resources/Textures/" + getCurrentModels[i] + "/" + txt + j + ".png";
                    fileData = File.ReadAllBytes(filePath);
                    tex = new Texture2D(2, 2);
                    tex.LoadImage(fileData);
                    slices[j] = tex;
                }
            }
        }
        if (nLOD > count + 1)
            count++;
    }

    //Get children of LODGroups in the scene
    GameObject findChildrenLODGroup(string parentName, string childName)
    {
        string childLocation = "/" + parentName + "/" + childName;
        GameObject childObject = GameObject.Find(childLocation);
        return childObject;
    }

    //Destroy the buffer if it's null
    private void OnDestroy()
    {
        if (_volumeBuffer != null)
        {
            Destroy(_volumeBuffer);
        }
    }

    //Generate the 3D textures and apply shaders toi do the ray-casting
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        for (int i = 0; i < volumeBufferArray.Count; i++)
        {
            _rayMarchMaterial.SetTexture("_VolumeTex", volumeBufferArray[i]);
        }

        var width = source.width;
        var height = source.height;

        frontDepth = RenderTexture.GetTemporary(width, height, 0, RenderTextureFormat.ARGBFloat);
        backDepth = RenderTexture.GetTemporary(width, height, 0, RenderTextureFormat.ARGBFloat);

        var volumeTarget = RenderTexture.GetTemporary(width, height, 0);
        generateRenderingCamera();

        // Render volume
        _rayMarchMaterial.SetTexture("_FrontTex", frontDepth);
        _rayMarchMaterial.SetTexture("_BackTex", backDepth);

        _rayMarchMaterial.SetVector("_ClipPlane", Vector4.zero);
        _rayMarchMaterial.SetFloat("_Opacity", opacity); // Blending strength 
        _rayMarchMaterial.SetVector("_ClipDims", clipDimensions / 100f); // Clip box


        Graphics.Blit(null, volumeTarget, _rayMarchMaterial);
        Graphics.Blit(null, volumeTarget, _rayMarchMaterial);

        //Composite
        _compositeMaterial.SetTexture("_BlendTex", volumeTarget);
        Graphics.Blit(source, destination, _compositeMaterial);
        Graphics.Blit(source, destination, _compositeMaterial);

        RenderTexture.ReleaseTemporary(volumeTarget);
        RenderTexture.ReleaseTemporary(frontDepth);
        RenderTexture.ReleaseTemporary(backDepth);

    }

    //Create the rendering camera
    private void generateRenderingCamera()
    {
        if (_ppCamera == null)
        {
            var go = new GameObject("ShotCamera");
            _ppCamera = go.AddComponent<Camera>();
            _ppCamera.enabled = false;
        }

        _ppCamera.CopyFrom(GetComponent<Camera>());
        _ppCamera.clearFlags = CameraClearFlags.SolidColor;
        _ppCamera.cullingMask = volumeLayer;
        
        _ppCamera.targetTexture = frontDepth;
        _ppCamera.RenderWithShader(renderFrontDepthShader, "RenderType");
        _ppCamera.targetTexture = backDepth;
        _ppCamera.RenderWithShader(renderBackDepthShader, "RenderType");
    }

    //Generate 3D texture
    private void GenerateVolumeTexture(string name, bool lodLevel, int lod)
    {
        _volumeBuffer = new Texture3D(volumeWidth, volumeHeight, volumeDepth, TextureFormat.ARGB32, false);
        volumeBufferArray.Add(_volumeBuffer);

        var w = _volumeBuffer.width;
        var h = _volumeBuffer.height;
        var d = _volumeBuffer.depth;
        
        //Load the textures
        drawTexture(name, lod.ToString(), lod);
        
        var countOffset = (slices.Length - 1) / (float)d;
        var volumeColors = new Color[w * h * d];

        //Load the textures in the array to the volume buffer and pass it to the shader
        var sliceCount = 0;
        var sliceCountFloat = 0f;
        for (int z = 0; z < d; z++)
        {
            sliceCountFloat += countOffset;
            sliceCount = Mathf.FloorToInt(sliceCountFloat);
            for (int x = 0; x < w; x++)
            {
                for (int y = 0; y < h; y++)
                {
                    var idx = x + (y * w) + (z * (w * h));
                    volumeColors[idx] = slices[sliceCount].GetPixelBilinear(x / (float)w, y / (float)h);
                    if (increaseVisiblity)
                    {
                        volumeColors[idx].a *= volumeColors[idx].r;
                    }
                }
            }
        }
        _volumeBuffer.SetPixels(volumeColors);
        _volumeBuffer.Apply();
        _rayMarchMaterial.SetTexture("_VolumeTex", _volumeBuffer);
    }
}

