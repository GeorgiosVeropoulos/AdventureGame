using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class enemyhealth : MonoBehaviour
{
    public int health = 4;
    
    public EnemyController controller;
    // Start is called before the first frame update
    void Start()
    {
        
        //controller.GetComponent<EnemyController>();
    }

    // Update is called once per frame
    public void Update()
	{
        if(health <= 0)
		{
            
            controller.isDead = true;
		}
		else
		{
            controller.isDead = false;
		}
	}

	public void DoDamage()
	{
        health -= 1;
        //anim.Play("Get Hit");
	}

}
