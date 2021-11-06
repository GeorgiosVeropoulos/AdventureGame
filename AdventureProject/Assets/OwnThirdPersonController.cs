using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OwnThirdPersonController : MonoBehaviour
{


    public FixedJoystick LeftJoystick;
    public FixedButton Attack;
    public FixedTouchField Touchfield;
    protected Animator anim;

    
    protected Rigidbody Rigidbody;
    protected float CameraAngleY;
    protected float CameraAngleSpeed = 0.1f;
    protected float CameraPosY;
    protected float CameraPosSpeed = 0.1f;
    void Start()
    {
        Rigidbody = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
        anim.SetBool("Attack", false);
    }

    // Update is called once per frame
    void Update()
    {
        anim.SetBool("Attack", false);
        var Input = new Vector3(LeftJoystick.input.x, 0, LeftJoystick.input.y);
        var vel = Quaternion.AngleAxis(CameraAngleY + 180, Vector3.up) * Input * 4f;


        Rigidbody.velocity = new Vector3(vel.x, Rigidbody.velocity.y, vel.z);
        transform.rotation = Quaternion.AngleAxis(CameraAngleY + 180 + Vector3.SignedAngle(Vector3.forward,
            Input.normalized + Vector3.forward * 0.001f, Vector3.up), Vector3.up);

        CameraAngleY += Touchfield.TouchDist.x * CameraAngleSpeed;
        Camera.main.transform.position = transform.position + Quaternion.AngleAxis(CameraAngleY, Vector3.up) * new Vector3(0, 3, 4);
        Camera.main.transform.rotation = Quaternion.LookRotation(transform.position + Vector3.up * 2f - Camera.main.transform.position, Vector3.up);
        if(Attack.Pressed == true)
		{
            anim.SetBool("Attack", true);
		}
        
        anim.SetFloat("Speed", Rigidbody.velocity.magnitude);
    }
}
