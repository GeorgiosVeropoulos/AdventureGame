using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamagePlayer : MonoBehaviour
{

    public bool CanDamage;
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
        if (CanDamage == true)
        {
            if (other.tag == "Player")
            {
                if (other.GetComponent<PlayerHealth>().health > 0)
                {
                    Debug.Log("Will do damage");
                    other.GetComponent<Animator>().Play("GotHit");
                    other.GetComponent<PlayerHealth>().DoDamage();
                    
                }
                else
                {

                }



            }
        }

    }
}
