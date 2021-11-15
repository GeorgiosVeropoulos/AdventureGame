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

    public bool canjump = false;
    public bool combo;
    public int combostep;
    public bool stopmove = true;
    //public CameraController camcontrol;
 

    void Start()
    {
        Rigidbody = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
        //anim.SetBool("Attack", false);
        
        

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
            RaycastHit hit;
            //Physics.Raycast(transform.position - new Vector3(0, -0.5f, 0), Vector3.down, 0.75f)
            if (Physics.Raycast(transform.position - new Vector3(0, -0.5f, 0),Vector3.down, out hit, 0.75f))
            {

                Debug.DrawRay(transform.position - new Vector3(0, -0.5f, 0), Vector3.down * hit.distance, Color.green);
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
                    Rigidbody.velocity = new Vector3(0, AdjustVelocityToSlope(Rigidbody.velocity).y, 0);
                    anim.SetFloat("Speed", Rigidbody.velocity.magnitude);

                }


            }
            else
            {
               // Debug.Log("AIR");
                anim.SetBool("isGround", false);
                var Input = new Vector3(LeftJoystick.input.x, 0, LeftJoystick.input.y);
                transform.rotation = Quaternion.AngleAxis(CameraAngleX + 180 + Vector3.SignedAngle(Vector3.forward,
                       Input.normalized + Vector3.forward * 0.001f, Vector3.up), Vector3.up); 
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
                //if (combostep == 2 && combo == false)
                //{
                //    combostep = 0;
                //}

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
            combostep = 0;

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
    public bool isFront(Transform from, Transform to)
    {
        Vector3 directionOfPlayer = from.position - to.position;
        float angle = Vector3.Angle(transform.forward, directionOfPlayer);

        if (Mathf.Abs(angle) > 90 && Mathf.Abs(angle) < 270)
        {
           
            return true;
        }
        return false;
    }

    public void Jump()
	{
        if (anim.GetBool("isGround") == true)
        {
			this.transform.position = new Vector3(this.transform.position.x, this.transform.position.y + 0.2f, this.transform.position.z);
			Rigidbody.AddForce(0, 7f, 0, ForceMode.Impulse);
            //Invoke("Waitforjump", 1f);
            ///anim.SetBool("isGround", false);
        }
    }
    
}
