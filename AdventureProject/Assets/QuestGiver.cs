using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QuestGiver : MonoBehaviour
{

    public QuestBase quest;


    // Start is called before the first frame update
    void Start()
    {
        quest.InitializeQuest();
        Debug.Log("QUEST KILL ORC STARTED");
    }

	//private void OnTriggerEnter(Collider other)
	//{
 //       if(other.tag == "Player")
	//	{
 //           quest.InitializeQuest();
 //       }
            
 //   }
}
