#pragma
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

public class VMCMob : MonoBehaviour {

    private Camera _cam1;
    private Mesh _m1;
    private Texture2D tex;
    private Shader cullOffShader;
    private Material mat;
    private Camera shotCamera, mainCamera;
    private GameObject instance, item;
    private Button button_charge, button_create;
    public static List<float> positionsArrayClone;
    private InputField input;
    string path, file;
    private Vector3 screenPoint;
    private Vector3 offset;
    private List<string> arrayNames;
    int n;
    int count = 1;
    GameObject lodObject;

    void Start()
    {
        positionsArrayClone = new List<float>();
        arrayNames = new List<string>();
        n = PlayerPrefs.GetInt("CustomShots");
        for (int i = 0; i < n; i++)
            positionsArrayClone.Add(PlayerPrefs.GetFloat("Position" + i));
    }

    //Create a quad mesh
    public Mesh CreateMesh()
    {
        Mesh mesh = new Mesh();
        Vector3 size = new Vector3(GameObject.FindGameObjectWithTag("model").GetComponent<MeshRenderer>().bounds.size.x, GameObject.FindGameObjectWithTag("model").GetComponent<MeshRenderer>().bounds.size.y, 0);

        Vector3[] vertices = new Vector3[]
        {
            new Vector3( size.x, size.y,  0),  //REVISAR TAMANYO
            new Vector3( size.x, -size.y, 0),
            new Vector3(-size.x, size.y, 0),
            new Vector3(-size.x, -size.y, 0)
        };

        Vector2[] uv = new Vector2[]
        {
            new Vector2(1, 1),
            new Vector2(1, 0),
            new Vector2(0, 1),
            new Vector2(0, 0)
        };

        int[] triangles = new int[]
        {
            0, 1, 2,
            2, 1, 3
        };

        mesh.vertices = vertices;
        mesh.uv = uv;
        mesh.triangles = triangles;
        mesh.RecalculateNormals();
        
        return mesh;
    }
    
    //Create and positionate the geometry in the correct position
    public void createVMCObject(string name)
    {
        Start();
        lodObject = new GameObject("VMCMob", typeof(MeshRenderer), typeof(MeshFilter));
        for (int j = 0; j < n; j++)
        {
           
            //Create mesh objects
            item = new GameObject(name + j, typeof(MeshRenderer), typeof(MeshFilter));    // Required to have a mesh
            arrayNames.Add(name+j);
            _m1 = CreateMesh();
            //_m1 = generateBox();
            item.GetComponent<MeshFilter>().mesh = _m1;
            item.transform.SetParent(lodObject.transform);

            // Set the position of the original model
            Vector3 pos = GameObject.FindGameObjectWithTag("model").transform.position;
            Vector3 size = GameObject.FindGameObjectWithTag("model").GetComponent<Renderer>().bounds.size;
            lodObject.transform.position = new Vector3(pos.x, pos.y + pos.y / 3, pos.z + size.z / 2);
            item.transform.position = new Vector3(lodObject.transform.position.x, lodObject.transform.position.y, lodObject.transform.position.z + j*0.01f);
            item.transform.localScale = GameObject.FindGameObjectWithTag("model").GetComponent<Renderer>().bounds.size;

            Vector3 texture = GameObject.FindGameObjectWithTag("model").GetComponent<MeshRenderer>().bounds.size;
            float scale = (float)(Screen.height / 2.0) / Camera.main.orthographicSize;
            item.transform.localScale = texture/scale;
        }
    }

    //Get the children of LODGroups
    GameObject findChildrenLODGroup(string parentName1, string parentName, string childName)
    {
        string childLocation = "/" + parentName1 + "/" + parentName + "/" + childName;
        GameObject childObject = GameObject.Find(childLocation);
        return childObject;
    }

    //Load textures and apply them to geometry
    public void applyTexturesToGeometry(string txt, string geometryName, string lodSelected, int nLOD)
    {
        GameObject[] allObjects = FindObjectsOfType<GameObject>();
        string[] gameObjectNames = new string[allObjects.Length];
        string currentPath= "";
        List<string> getCurrentModels = new List<string>();

        //Create a directory for the model if dont exist
        for(int i = 0; i < allObjects.Length; i++)
        {
            gameObjectNames[i] = allObjects[i].name;
            if (Directory.Exists("Assets/Resources/Textures/" + gameObjectNames[i]))
            {
                currentPath = gameObjectNames[i];
                getCurrentModels.Add(currentPath);
            }
        }

        //Apply textures for all the geometry
        for (int i = 0; i < getCurrentModels.Count; i++)
        {
            Debug.Log("LOD Selected: "+ getCurrentModels[i] + count + ", " + "LOD" + lodSelected + "Group");
            //Create object with texture size
            for (int j = 0; j < n; j++)
            {
                //Set textures
                byte[] fileData;
                string filePath = "";
                string id = "1";

                //Apply to the correct model
                GameObject itemTexture = findChildrenLODGroup("LOD"+lodSelected+"Group", getCurrentModels[i] + count, geometryName + j);

                if (getCurrentModels[i] == GameObject.FindGameObjectWithTag("model").name)
                {
                    filePath = "Assets/Resources/Textures/" + getCurrentModels[i] + "/" + txt + j + ".png";
                    fileData = File.ReadAllBytes(filePath);
                    tex = new Texture2D(2, 2);
                    tex.LoadImage(fileData);

                    //Set shader for this sprite with cull off to see double-sided plane
                    cullOffShader = Shader.Find("Transparent/Cutout/Diffuse/Cull Off");
                    Material mat = new Material(cullOffShader);
                    itemTexture.GetComponent<Renderer>().sharedMaterial = mat;
                    itemTexture.GetComponent<Renderer>().sharedMaterial.name = "textures" + j;
                    itemTexture.GetComponent<Renderer>().sharedMaterial.mainTexture = tex;


                }
            }
        }
        if (nLOD > count + 1)
            count++;
    }
}
