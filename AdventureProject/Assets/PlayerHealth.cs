using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : MonoBehaviour
{
    public int health = 5;

    public Animator controller;
    private int Dead;
    private int Attacked;
    private int death;

    // Start is called before the first frame update
    private void Awake()
	{
        Dead = Animator.StringToHash("Dead");
        Attacked = Animator.StringToHash("Attacked");
        death = Animator.StringToHash("Death");

    }
    void Start()
    {
        controller.SetBool(Dead, false);

    }

    // Update is called once per frame
    public void Update()
    {
        if (health <= 0)
        {
            //Debug.Log("Player DEATH");
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
        //Debug.Log("Player got hit");
        controller.SetBool(Attacked, false);

        //anim.Play("Get Hit");
    }
    public void Death()
	{
        controller.SetBool(Dead, true);
        controller.Play(death);
    }
}
