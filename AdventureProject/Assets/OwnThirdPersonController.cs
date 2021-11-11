using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OwnThirdPersonController : MonoBehaviour
{


    public FixedJoystick LeftJoystick;
    //public FixedButton Attack;
    public FixedTouchField Touchfield;
    protected Animator anim;
    public AttackDamageScript Swordscript;
    public bool blockonCD;
    
    protected Rigidbody Rigidbody;
    protected float CameraAngleX;
    protected float CameraAngleSpeed = 0.1f;
    public float  CameraDistance;
    protected float CameraPosSpeed = 0.1f;
    public GameObject pos;
    public bool isGrounded;
    public bool combo;
    public int combostep;
    public bool stopmove = true;
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
        if(anim.GetBool("Dead") == false)
		{
            CameraAngleX += Touchfield.TouchDist.x * CameraAngleSpeed;
            Camera.main.transform.position = transform.position + Quaternion.AngleAxis(CameraAngleX, Vector3.up) * new Vector3(0, 3, CameraDistance);
            Camera.main.transform.rotation = Quaternion.LookRotation(transform.position + Vector3.up * 2f - Camera.main.transform.position, Vector3.up);
            //anim.SetBool("Attack", false);
            if (Physics.Raycast(transform.position - new Vector3(0, -0.5f, 0), Vector3.down, 0.65f))
            {

                Debug.Log("Grounded");
                anim.SetBool("isGround", true);

                var Input = new Vector3(LeftJoystick.input.x, 0, LeftJoystick.input.y);
                var vel = Quaternion.AngleAxis(CameraAngleX + 180, Vector3.up) * Input * 4f;
                

                if (stopmove == false)
                {
                    Rigidbody.velocity = new Vector3(vel.x, AdjustVelocityToSlope(Rigidbody.velocity).y, vel.z);
                    
                    transform.rotation = Quaternion.AngleAxis(CameraAngleX + 180 + Vector3.SignedAngle(Vector3.forward,
                        Input.normalized + Vector3.forward * 0.001f, Vector3.up), Vector3.up);
                    anim.SetFloat("Speed", Rigidbody.velocity.magnitude);
                }
                else
                {
                    Rigidbody.velocity = new Vector3(0, 0, 0);
                    anim.SetFloat("Speed", Rigidbody.velocity.magnitude);

                }



                //if (Attack.Pressed == true)
                //{
                //    anim.SetBool("Attack", true);
                //}


            }
            else
            {
                Debug.Log("AIR");
                anim.SetBool("isGround", false);
                //Rigidbody.velocity = new Vector3(5f, Rigidbody.velocity.y, 5f);
                anim.SetFloat("Speed", 2f);
            }

        }
		else
		{

		}





    }

    public void AttackAnim()
    {
        if(anim.GetBool("Dead") == false)
		{
            if (combostep == 0)
            {
                anim.Play("Attack");
                anim.SetBool("Attack", true);
                //Swordscript.CanDoDamage = true;
                combostep = 1;
                return;
            }

            if (combostep != 0)
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
        anim.SetBool("Attack", false);
        //Swordscript.CanDoDamage = false;
    }
    public void CanDamage()
	{
        Swordscript.CanDoDamage = true;
	}
    public void CantDamage()
	{
        Swordscript.CanDoDamage = false;
    }

    public void Block()
	{
        combostep = 0;
        combo = false;
        if(blockonCD == false)
		{
            anim.Play("Block");
            anim.SetBool("Blocking", true);
            Invoke("resetblockbool", 1.3f);
            Invoke("ResetBlockCD", 4.0f);
            blockonCD = true;
        }
        
	}
    void ResetBlockCD()
    {
        blockonCD = false;
    }
    void resetblockbool()
	{
        anim.SetBool("Blocking", false);
	}
    // Adjust velocity to go down slopes without jumping/falling
    private Vector3 AdjustVelocityToSlope(Vector3 velocity)
	{
        var ray = new Ray(transform.position, Vector3.down);

        if(Physics.Raycast(ray, out RaycastHit hitInfo, 0.5f))
		{
            var slopeRotation = Quaternion.FromToRotation(Vector3.up, hitInfo.normal);
            var adjustedVelocity = slopeRotation * velocity;


            if(adjustedVelocity.y < 0)
			{
                return adjustedVelocity;
			}
		}

        return velocity;
	}
}
