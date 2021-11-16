using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : MonoBehaviour
{
    public int health = 5;

    public Animator controller;
	// Start is called before the first frame update
	private void Awake()
	{
        
        
	}
	void Start()
    {
        controller.SetBool("Dead", false);

    }

    // Update is called once per frame
    public void Update()
    {
        if (health <= 0)
        {
            Debug.Log("Player DEATH");
            Death();
            
        }
        else
        {
            //controller.isDead = false;
        }
    }


	

	public void DoDamage()
    {
        health -= 1;
        Debug.Log("Player got hit");
        controller.SetBool("Attacked", false);

        //anim.Play("Get Hit");
    }
    public void Death()
	{
        controller.SetBool("Dead", true);
        controller.Play("Death");
    }
}
