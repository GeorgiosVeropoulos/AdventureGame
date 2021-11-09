using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class enemyhealth : MonoBehaviour
{
    public int health = 4;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
	{
        if(health <= 0)
		{
            Debug.Log("ENEMY DEATH");
		}
	}

	public void DoDamage()
	{
        health -= 1;
	}

}
