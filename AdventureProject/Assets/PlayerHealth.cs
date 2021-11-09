using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : MonoBehaviour
{
    public int health = 5;

    public Animator controller;
    // Start is called before the first frame update
    void Start()
    {

        controller = this.GetComponent<Animator>();
    }

    // Update is called once per frame
    public void Update()
    {
        if (health <= 0)
        {
            Debug.Log("Player DEATH");
            //controller.isDead = true;
        }
        else
        {
            //controller.isDead = false;
        }
    }


	private void FixedUpdate()
	{
        
    }

	public void DoDamage()
    {
        health -= 1;
        Debug.Log("Player got hit");
        controller.SetBool("Attacked", false);
        //anim.Play("Get Hit");
    }
}
