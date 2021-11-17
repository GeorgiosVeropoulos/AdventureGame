using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamagePlayer : MonoBehaviour
{

    public bool CanDamage;
    public OwnThirdPersonController playercontroller;
    public PlayerHealth playerhealth;
    public Animator PlayerAnim;
    
    // Start is called before the first frame update
    void Awake()
    {
        
        //playercontroller = GetComponent<OwnThirdPersonController>();
    }

    
    private void OnTriggerEnter(Collider other)
    {
        //Vector3 target = (player.position - thisorc.position).normalized;
        if (CanDamage == true)
        {
            if (other.tag == "Player")
            {
                
                //if (Vector3.Dot(target, transform.forward) > 0)
                if(playercontroller.isFront(this.transform.parent,other.transform) == true)
                {

                    //Debug.Log("Player isnt looking at enemy");
                    if (playerhealth.health > 0)
                    {

                       
                        PlayerAnim.Play("GotHit");
                        playerhealth.DoDamage();

                    }

                }
				else
				{
                    
                    //Debug.Log("Player is looking at enemy");


                    if (PlayerAnim.GetBool("Blocking") == false)
                    {

                        if (playerhealth.health > 0)
                        {
                            //Debug.Log("Will do damage");
                            PlayerAnim.Play("GotHit");
                            playerhealth.DoDamage();

                        }
                    }
					else
					{
                        PlayerAnim.Play("GotHit");
                    }
                }
                
                
                



            }
        }

    }

    
}
