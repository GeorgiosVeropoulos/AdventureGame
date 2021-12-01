using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WindmillTurnVisible : MonoBehaviour
{
    
    public rotate rotator;
    private void OnBecameVisible()
    {
        //npc.isClose = true;
        rotator.visible = true;
    }
    private void OnBecameInvisible()
    {
        //npc.isClose = false;
        rotator.visible = false;
    }
}
