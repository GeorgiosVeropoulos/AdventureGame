using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamagePlayer : MonoBehaviour
{

    public bool CanDamage;
    public OwnThirdPersonController playercontroller;
    // Start is called before the first frame update
    void Start()
    {
        //playercontroller = GetComponent<OwnThirdPersonController>();
    }

    // Update is called once per frame
    void Update()
    {
       
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

                    Debug.Log("Player isnt looking at enemy");
                    if (other.GetComponent<PlayerHealth>().health > 0)
                    {
                        Debug.Log("Will do damage");
                        other.GetComponent<Animator>().Play("GotHit");
                        other.GetComponent<PlayerHealth>().DoDamage();

                    }

                }
				else
				{
                    
                    Debug.Log("Player is looking at enemy");


                    if (other.GetComponent<Animator>().GetBool("Blocking") == false)
                    {

                        if (other.GetComponent<PlayerHealth>().health > 0)
                        {
                            //Debug.Log("Will do damage");
                            other.GetComponent<Animator>().Play("GotHit");
                            other.GetComponent<PlayerHealth>().DoDamage();

                        }
                    }
					else
					{
                        other.GetComponent<Animator>().Play("GotHit");
                    }
                }
                
                
                



            }
        }

    }

    
}
