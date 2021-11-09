using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyController : MonoBehaviour
{

    
    private float cooldownTime = 1.6f;  // swingtimer
    private bool isCooldown;
    

    public Transform Player;
    public Transform oldlook;
    public Transform startingPosition;
    NavMeshAgent agent;
    Animator EnemyAnim;
    Rigidbody rigidbody;

    public bool isDead;
    public bool canChase;
    public float animspeed = 0; 
    public float minDist = 5;
    public float maxDist = 10;
    // Start is called before the first frame update
    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
        EnemyAnim = GetComponent<Animator>();
        rigidbody = GetComponent<Rigidbody>();
        isDead = false;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //transform.LookAt(Player);
        if(isDead == false)
		{
            if (Vector3.Distance(transform.position, Player.position) <= maxDist)
            {
                //Debug.Log("aggro");

                agent.isStopped = false;
                //animspeed = animspeed + 0.001f;
                //EnemyAnim.SetFloat("Speed", animspeed);
                if (canChase == true)
                {
                    if (Vector3.Distance(transform.position, Player.position) >= minDist)
                    {
                        //transform.LookAt(Player);
                        //transform.position += transform.forward * speed * Time.deltaTime;
                        agent.isStopped = false;
                        EnemyAnim.SetFloat("Speed", 2);
                        agent.SetDestination(Player.position);

                        //Debug.Log("Chasing");
                        FaceTarget();

                    }
                    else
                    {
                        EnemyAnim.SetFloat("Speed", 0);
                        agent.isStopped = true;
                        if (!isCooldown)
                        {
                            // handles the attack swing
                            StartCoroutine("SwingTimer");
                        }
                    }
                }


            }
            else
            {
                Debug.Log("RESETTING");

                if (Vector3.Distance(transform.position, startingPosition.position) >= 1f)
                {
                    canChase = false;
                    EnemyAnim.SetFloat("Speed", 1.4f);
                    agent.isStopped = false;
                    agent.SetDestination(startingPosition.position);

                }
                else
                {
                    canChase = true;
                    agent.isStopped = true;
                    EnemyAnim.SetFloat("Speed", 0);
                }
                transform.LookAt(oldlook);
            }
        }
		else
		{
            EnemyAnim.SetBool("Dead", true);
            this.GetComponent<CapsuleCollider>().isTrigger = true;
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

    private IEnumerator SwingTimer()
	{
        isCooldown = true;
        EnemyAnim.SetBool("Attack", true);
        EnemyAnim.Play("Attack");
        yield return new WaitForSeconds(cooldownTime);
        EnemyAnim.SetBool("Attack", false);
        isCooldown = false;
	}

    
}
