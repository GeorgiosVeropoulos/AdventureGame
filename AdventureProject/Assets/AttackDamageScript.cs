using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackDamageScript : MonoBehaviour
{
    public bool CanDoDamage = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
	private void OnTriggerEnter(Collider other)
	{
        if(CanDoDamage == true)
		{
            if (other.tag == "Enemy")
            {
                if(other.GetComponent<EnemyController>().canChase == true)
				{
                    
                    if (other.GetComponent<enemyhealth>().health > 0)
                    {
                        Debug.Log("Will do damage");
                        other.GetComponent<enemyhealth>().DoDamage();
                        other.GetComponent<Animator>().Play("Get Hit"); // this works check enemy health for next version
                    }
                    else
                    {

                    }
                }
				else
				{

				}
                
               

            }
        }
		
	}
}
