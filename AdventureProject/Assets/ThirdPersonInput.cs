using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.ThirdPerson;

public class ThirdPersonInput : MonoBehaviour
{
    public FixedJoystick LeftJoyStick;
    public FixedButton Button;
    public FixedButton AttackButton;
    protected ThirdPersonUserControl Control;
    public FixedTouchField TouchField;
    //public ThirdPersonCharacter tpc;

    protected float CameraAngle;
    protected float CameraAngleSpeed = 0.2f;

    // Start is called before the first frame update
    void Start()
    {
        Control = GetComponent<ThirdPersonUserControl>();
    }

    // Update is called once per frame
    void Update()
    {
        if(AttackButton.Pressed == true)
		{
            //Control.Attack = true;
            //tpc.m_Attack = true;
		}
		else
		{
            //tpc.m_Attack = false;
            //Control.att = false;
		}
		//Debug.Log(Control.Attack);
		Control.m_Jump = Button.Pressed;
		Control.Hinput = LeftJoyStick.input.x;
		Control.Vinput = LeftJoyStick.input.y;


		CameraAngle += TouchField.TouchDist.x * CameraAngleSpeed;

        Camera.main.transform.position = transform.position + Quaternion.AngleAxis(CameraAngle, Vector3.up) * new Vector3(0, 3, 4);
        Camera.main.transform.rotation = Quaternion.LookRotation(transform.position + Vector3.up * 2f - Camera.main.transform.position, Vector3.up);
    }
}
