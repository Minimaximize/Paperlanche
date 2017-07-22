using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof(Rigidbody))]
public class PlayerMovement : MonoBehaviour
{
	private Rigidbody rb;
	//Movement Variables
	public float maxSpeed;
	private float currentSpeed = 0f;
	private Rigidbody Reticle;

	//Collider Variables

	//Fire Prefabs
	public Collider hitCollider;



	// Use this for initialization
	void Start ()
	{
		rb = GetComponent<Rigidbody> ();
		Reticle = GameObject.FindGameObjectWithTag ("Reticle").GetComponent<Rigidbody> ();

	}
	
	// Update is called once per frame
	void FixedUpdate ()
	{
		float hm = Input.GetAxis ("Horizontal");
		float vm = Input.GetAxis ("Vertical");
		Vector3 next = new Vector3 (hm, 0, vm);
		Vector3 dir = rb.position - Reticle.position;
		dir.y = 0;
		Mover (next);
		Facing (-dir);
		if (Input.GetMouseButtonDown (0)) {
			
		}
	}

	/// <summary>
	/// Controls the movement of the player object
	/// </summary>
	/// <param name="input">The input direction of the player</param>
	void Mover (Vector3 input)
	{
		rb.velocity = input * maxSpeed;
	}

	/// <summary>
	/// Controls the Direction the player is facing
	/// </summary>
	/// <param name="input">the look direction of the player</param>
	void Facing (Vector3 input)
	{
		rb.rotation = Quaternion.LookRotation (input);
	}

	void Fire ()
	{
		
	}

	void OnCollisionEnter (Collision collision)
	{
		
	}

}
