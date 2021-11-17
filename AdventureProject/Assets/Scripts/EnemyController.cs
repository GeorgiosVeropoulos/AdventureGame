using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyController : MonoBehaviour
{
    public EnemyProfile enemyprofile;
    

    private float cooldownTime = 1.6f;  // swingtimer
    private bool isCooldown;
    

    public Transform Player;
    public Transform oldlook;
    public Transform startingPosition;
    NavMeshAgent agent;
    Animator EnemyAnim;
    
    public DamagePlayer AxeDamage;

    public bool goingtopoint;
    public bool isDead;
    public bool canChase;
    
    public float minDist = 5;
    public float maxDist = 10;
    private int Speed;
    private int swingtimer;
    private int attack;
    private int attackbool;

	private void Awake()
	{
        Speed = Animator.StringToHash("Speed");
        swingtimer = Animator.StringToHash("SwingTimer");
        attack = Animator.StringToHash("Attack");
        attackbool = Animator.StringToHash("attack");
        swingtimer = Animator.StringToHash("SwingTimer");


    }

    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
        EnemyAnim = GetComponent<Animator>();
       
        isDead = false;
        
    }

    
    void FixedUpdate()
    {
        //transform.LookAt(Player);
        if(isDead == false)
		{
            if(goingtopoint == false)
			{
                if (Vector3.Distance(transform.position, Player.position) <= maxDist)
                {
                    //Debug.Log("aggro");
                    maxDist = 200f;
                    agent.isStopped = false;
                    
                    if (canChase == true)
                    {
                        if (Vector3.Distance(transform.position, Player.position) >= minDist)
                        {
                            //transform.LookAt(Player);
                            //transform.position += transform.forward * speed * Time.deltaTime;
                            agent.isStopped = false;
                            EnemyAnim.SetFloat(Speed, 2);
                            agent.SetDestination(Player.position);

                            //Debug.Log("Chasing");
                            FaceTarget(Player);

                        }
                        else
                        {
                            EnemyAnim.SetFloat(Speed, 0);
                            agent.isStopped = true;

                            if (!isCooldown)
                            {
                                // handles the attack swing

                                StartCoroutine("SwingTimer");
                            }
                        }

                        if (Vector3.Distance(transform.position, startingPosition.position) >= 30f)
                        {
                            Reset();
                        }
                    }


                }
                else
                {
                   

                }
            }
			else
			{
                Reset();
			}
			
           
        }
		else
		{
            EnemyAnim.SetBool("Dead", true);

            this.GetComponent<CapsuleCollider>().isTrigger = true;

            if (GameManager.instance.onEnemyDeathCallBack != null) GameManager.instance.onEnemyDeathCallBack.Invoke(enemyprofile);
		}
        

    }

	//private void OnDrawGizmos()
	//{
 //       Gizmos.color = Color.blue;
 //       Gizmos.DrawWireSphere(transform.position, maxDist);
	//	Gizmos.color = Color.red;
	//	Gizmos.DrawWireSphere(startingPosition.position, 30f);
	//}

    void FaceTarget(Transform target)
	{
        Vector3 direction = (target.position - transform.position).normalized;
        Quaternion lookRotation = Quaternion.LookRotation(new Vector3(direction.x, 0, direction.z));
        transform.rotation = Quaternion.Slerp(transform.rotation, lookRotation, Time.deltaTime * 5f);

	}

	public void Reset()
	{
        //Debug.Log("RESETTING");
        maxDist = 10f;
        if (Vector3.Distance(transform.position, startingPosition.position) >= 1f)
        {
            canChase = false;
            goingtopoint = true;
            EnemyAnim.SetFloat(Speed, 1.4f);
            agent.isStopped = false;
            agent.SetDestination(startingPosition.position);

        }
        else
        {
            goingtopoint = false;
            canChase = true;
            agent.isStopped = true;
            EnemyAnim.SetFloat(Speed, 0);
        }
        FaceTarget(startingPosition);
    }

	private IEnumerator SwingTimer()
	{
        isCooldown = true;
        EnemyAnim.SetBool(attackbool, true);
        EnemyAnim.Play(attack);
        Invoke("enableCanDamage", 0.3f);
        
        yield return new WaitForSeconds(0.6f);
        // will wait 0.6 seconds after swing start to disable collider 
        // just enough time to hit and not be able to do damage after if we run into the axe
        AxeDamage.CanDamage = false;
        yield return new WaitForSeconds(cooldownTime);
        
        EnemyAnim.SetBool(attackbool, false);
        isCooldown = false;
        

        
    }
    void enableCanDamage()
	{
        AxeDamage.CanDamage = true;
    }

    
}
