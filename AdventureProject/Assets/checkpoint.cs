using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class checkpoint : MonoBehaviour
{
	public EnemyProfile enemyprofile;

	private void OnTriggerEnter(Collider other)
	{
		if (other.tag == "Player")
		{

			if (GameManager.instance.onEnemyDeathCallBack != null) GameManager.instance.onEnemyDeathCallBack.Invoke(enemyprofile);
		}

	}
}
