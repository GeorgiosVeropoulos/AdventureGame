//using System.Collections;
//using System.Collections.Generic;
//using UnityEngine;

//public class PlayerMovement : MonoBehaviour
//{
//    public float maximumSpeed;
//    public float rotationSpeed;
//    public float jumpSpeed;
//    public float jumpButtonGracePeriod;

//    private Animator animator;
//    private CharacterController characterController;
//    private float ySpeed;
//    private float originalStepOffset;
//    private float? lastGroundedTime;
//    private float? jumpButtonPressedTime;
//    public float horizontalInput;
//    public float verticalInput;

//    // Start is called before the first frame update
//    void Start()
//    {
//        animator = GetComponent<Animator>();
//        characterController = GetComponent<CharacterController>();
//        originalStepOffset = characterController.stepOffset;
//    }

//    // Update is called once per frame
//    void Update()
//    {
//        //float horizontalInput = Input.GetAxis("Horizontal");
//        //float verticalInput = Input.GetAxis("Vertical");

//        Vector3 movementDirection = new Vector3(horizontalInput, 0, verticalInput);
//        float inputMagnitude = Mathf.Clamp01(movementDirection.magnitude);

//        if (Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift))
//        {
//            inputMagnitude /= 2;
//        }

//        animator.SetFloat("Speed", inputMagnitude, 0.05f, Time.deltaTime);

//        float speed = inputMagnitude * maximumSpeed;
//        movementDirection.Normalize();

//        ySpeed += Physics.gravity.y * Time.deltaTime;

//        if (characterController.isGrounded)
//        {
//            lastGroundedTime = Time.time;
//        }

//        if (Input.GetButtonDown("Jump"))
//        {
//            jumpButtonPressedTime = Time.time;
//        }

//        if (Time.time - lastGroundedTime <= jumpButtonGracePeriod)
//        {
//            characterController.stepOffset = originalStepOffset;
//            ySpeed = -0.5f;

//            if (Time.time - jumpButtonPressedTime <= jumpButtonGracePeriod)
//            {
//                ySpeed = jumpSpeed;
//                jumpButtonPressedTime = null;
//                lastGroundedTime = null;
//            }
//        }
//        else
//        {
//            characterController.stepOffset = 0;
//        }

//        Vector3 velocity = movementDirection * speed;
//        velocity.y = ySpeed;

//        characterController.Move(velocity * Time.deltaTime);

//        if (movementDirection != Vector3.zero)
//        {
//            Quaternion toRotation = Quaternion.LookRotation(movementDirection, Vector3.up);

//            transform.rotation = Quaternion.RotateTowards(transform.rotation, toRotation, rotationSpeed * Time.deltaTime);
//        }
//        else
//        {
//            animator.SetBool("IsMoving", false);
//        }
//    }
//}
