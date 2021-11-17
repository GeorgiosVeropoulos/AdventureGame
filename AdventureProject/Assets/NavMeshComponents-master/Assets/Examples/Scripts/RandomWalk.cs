using UnityEngine;
using UnityEngine.AI;

// Walk to a random position and repeat
[RequireComponent(typeof(NavMeshAgent))]
public class RandomWalk : MonoBehaviour
{
    public float m_Range = 50.0f;
    public NavMeshAgent m_Agent;
    public Animator anim;

    void Start()
    {
        
    }

    void FixedUpdate()
    {
        if (m_Agent.pathPending || m_Agent.remainingDistance > 0.1f)
		{
           
            anim.SetFloat("Forward", m_Agent.speed / 3);
            return;
        }

        
        m_Agent.destination = m_Range * Random.insideUnitCircle;
    }
}
