using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHealth : MonoBehaviour
{
    public int health = 5;

    //public EnemyController controller;
    // Start is called before the first frame update
    void Start()
    {

        //controller.GetComponent<EnemyController>();
    }

    // Update is called once per frame
    public void Update()
    {
        if (health <= 0)
        {
            Debug.Log("ENEMY DEATH");
            //controller.isDead = true;
        }
        else
        {
            //controller.isDead = false;
        }
    }

    public void DoDamage()
    {
        health -= 1;
        //anim.Play("Get Hit");
    }
}
