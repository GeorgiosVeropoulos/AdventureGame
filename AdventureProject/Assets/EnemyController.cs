using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyController : MonoBehaviour
{

    public bool isChasing;
    public Transform Player;
    public Transform oldlook;
    public Transform startingPosition;
    NavMeshAgent agent;

    public float speed;
    public float minDist = 5;
    public float maxDist = 10;
    // Start is called before the first frame update
    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //transform.LookAt(Player);

        if (Vector3.Distance(transform.position, Player.position) <= maxDist)
        {
            Debug.Log("aggro");
            if (Vector3.Distance(transform.position, Player.position) >= minDist)
            {
                //transform.LookAt(Player);
                //transform.position += transform.forward * speed * Time.deltaTime;

                agent.SetDestination(Player.position);
                Debug.Log("Chasing");
                FaceTarget();

            }
			
        }
        else
        {
            Debug.Log("RESETTING");
            
            if (Vector3.Distance(transform.position, startingPosition.position) >= 1f)
			{
                agent.SetDestination(startingPosition.position);
                
            }
            transform.LookAt(oldlook);
        }

    }

	private void OnDrawGizmos()
	{
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, maxDist);
	}

    void FaceTarget()
	{
        Vector3 direction = (Player.position - transform.position).normalized;
        Quaternion lookRotation = Quaternion.LookRotation(new Vector3(direction.x, 0, direction.z));
        transform.rotation = Quaternion.Slerp(transform.rotation, lookRotation, Time.deltaTime * 5f);

	}
}
