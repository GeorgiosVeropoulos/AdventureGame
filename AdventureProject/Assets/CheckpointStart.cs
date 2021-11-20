using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckpointStart : MonoBehaviour
{
    public QuestBase quest;


    // Start is called before the first frame update
    void Start()
    {
        
    }

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag == "Player")
		{
			quest.InitializeQuest();
			Debug.Log("QUEST CHECKPOINT STARTED");
		}

	}
}
