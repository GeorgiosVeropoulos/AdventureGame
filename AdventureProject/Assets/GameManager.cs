using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

	private void Awake()
	{
		if(instance == null)
		{
			instance = this;
		}
	}
	public delegate void OnEnemyDeathCallBack(EnemyProfile enemyProfile);
    public OnEnemyDeathCallBack onEnemyDeathCallBack;
}
