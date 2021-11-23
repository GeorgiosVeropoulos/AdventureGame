using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckVisible : MonoBehaviour
{
    //public NPCnavpoints npc;
    public RandomWalk walk;
    private void OnBecameVisible()
    {
        //npc.isClose = true;
        walk.visible = true;
    }
    private void OnBecameInvisible()
    {
        //npc.isClose = false;
        walk.visible = false;
    }
}
