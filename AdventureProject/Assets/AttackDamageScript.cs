using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttackDamageScript : MonoBehaviour
{
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
		if(other.tag == "Enemy")
		{
            Debug.Log("Will do damage");
            other.GetComponent<enemyhealth>().DoDamage();
            other.GetComponent<Animator>().Play("Get Hit");
		}
	}
}
