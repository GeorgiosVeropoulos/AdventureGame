using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotate : MonoBehaviour
{

    //Assign a GameObject in the Inspector to rotate around
    public float speed;
    public bool visible;
    void FixedUpdate()
    {
        // Spin the object around the target at 20 degrees/second.
        //transform.RotateAround(target.transform.position, Vector3.zero, 20 * Time.deltaTime);
        if(visible == true)
		{
            transform.Rotate(0, 0, speed * Time.deltaTime);
		}
		else
		{

		}
            
    }
}
