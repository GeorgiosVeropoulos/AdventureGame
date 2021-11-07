using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
	public Camera camerapos;

	public float maxDistanceToCamera;
	public LayerMask layers;
	public OwnThirdPersonController controller;


	// Note to self dont fucking handle things like that on update
	public void LateUpdate()
	{
		Vector3 direction = camerapos.transform.position - transform.position;

		RaycastHit hit;
		if(Physics.Raycast(transform.position, direction, out hit,maxDistanceToCamera,layers))
		{
			
			float distance = Vector3.Distance(transform.position, hit.point);
			Debug.Log("HIT");
			controller.CameraDistance = distance;
		}
		else
		{
			Debug.Log(" NO HIT");
			controller.CameraDistance = maxDistanceToCamera;
		}
		Debug.DrawRay(transform.position, direction);
	}

}
