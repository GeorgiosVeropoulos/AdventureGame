﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OwnThirdPersonController : MonoBehaviour
{


    public FixedJoystick LeftJoystick;
    //public FixedButton Attack;
    public FixedTouchField Touchfield;
    protected Animator anim;

    
    protected Rigidbody Rigidbody;
    protected float CameraAngleX;
    protected float CameraAngleSpeed = 0.1f;
    public float  CameraDistance;
    protected float CameraPosSpeed = 0.1f;
    public GameObject pos;
    public bool isGrounded;
    public bool combo;
    public int combostep;
    //public CameraController camcontrol;
 

    void Start()
    {
        Rigidbody = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
        //anim.SetBool("Attack", false);
        isGrounded = true;
        

    }

    // Update is called once per frame
    void Update()
    {
        CameraAngleX += Touchfield.TouchDist.x * CameraAngleSpeed;
        Camera.main.transform.position = transform.position + Quaternion.AngleAxis(CameraAngleX, Vector3.up) * new Vector3(0, 3, CameraDistance);
        Camera.main.transform.rotation = Quaternion.LookRotation(transform.position + Vector3.up * 2f - Camera.main.transform.position, Vector3.up);
        //anim.SetBool("Attack", false);
        if (Physics.Raycast(transform.position - new Vector3(0,-0.5f,0), Vector3.down, 1f))
		{
            
            Debug.Log("Grounded");
            anim.SetBool("isGround", true);
            
            var Input = new Vector3(LeftJoystick.input.x, 0, LeftJoystick.input.y);
            var vel = Quaternion.AngleAxis(CameraAngleX + 180, Vector3.up) * Input * 4f;

           
            
            Rigidbody.velocity = new Vector3(vel.x, Rigidbody.velocity.y, vel.z);
            transform.rotation = Quaternion.AngleAxis(CameraAngleX + 180 + Vector3.SignedAngle(Vector3.forward,
                Input.normalized + Vector3.forward * 0.001f, Vector3.up), Vector3.up);

           
            //if (Attack.Pressed == true)
            //{
            //    anim.SetBool("Attack", true);
            //}

            anim.SetFloat("Speed", Rigidbody.velocity.magnitude);
        }
		else
		{
            Debug.Log("AIR");
            anim.SetBool("isGround", false);
		}

        

        
        
        
    }

    public void AttackAnim()
    {
        if (combostep == 0)
        {
            anim.Play("Attack");
            combostep = 1;
            return;
        }

        if(combostep != 0)
		{
            // this is testing for bug that (if combo is 1 it stays 1 and doesnt reset)
            if (combostep == 1 && combo == false)
            {
                combostep = 0;
            }
            if (combo)
			{
                combo = false;
                combostep += 1;
			}
           
        }
    }

    public void ComboPossible()
	{
        combo = true;
	}
    public void Combo()
	{
        if(combostep == 2)
		{
			anim.Play("Attack2");

		}
	}
    public void ComboReset()
	{
        combo = false;
        combostep = 0;
	}
}
