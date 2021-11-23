using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCnavpoints : MonoBehaviour
{
    public Transform[] points;
    private int destPoint = 0;
    public NavMeshAgent agent;
    public Animator anim;
    private int speed;
    public bool isClose;
    public GameObject player;


    private void Awake()
	{
        speed = Animator.StringToHash("Forward");
    }
	void Start()
    {
        
        
        
        // Disabling auto-braking allows for continuous movement
        // between points (ie, the agent doesn't slow down as it
        // approaches a destination point).
        //agent.autoBraking = true;
        anim.SetFloat(speed, agent.speed/4f);
        
        //agent.autoBraking = true;
        

    }


    void GotoNextPoint()
    {
        // Returns if no points have been set up
        if (points.Length == 0)
            return;

        // Set the agent to go to the currently selected destination.
        agent.destination = points[Random.Range(0, points.Length)].position;


        // Choose the next point in the array as the destination,
        // cycling to the start if necessary.
        //destPoint = (destPoint + 1) % points.Length;
    }

   
	
	

    

}
