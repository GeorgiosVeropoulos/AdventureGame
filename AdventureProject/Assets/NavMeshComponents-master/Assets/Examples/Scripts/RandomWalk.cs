using UnityEngine;
using UnityEngine.AI;

// Walk to a random position and repeat
[RequireComponent(typeof(NavMeshAgent))]
public class RandomWalk : MonoBehaviour
{
    public float m_Range = 25.0f;
    public NavMeshAgent m_Agent;
    public Animator anim;
    public bool visible;
    private int speed;
    public GameObject player;

    private void Awake()
	{
        speed = Animator.StringToHash("Forward");
    }

	void FixedUpdate()
    {
        if(visible == true)
		{
            if (m_Agent.pathPending || m_Agent.remainingDistance > 0.1f)
            {

                anim.SetFloat(speed, m_Agent.speed / 4f);
                return;
            }

            if (Vector3.Distance(transform.position, player.transform.position) <= 50f)
                m_Agent.destination = m_Range * Random.insideUnitCircle;
        }
		else
		{
            
		}
    }
}
