using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof(Rigidbody))]
public class EndlessRunnerMovement : MonoBehaviour
{
	//Public Variables
	//Health Variables
	public int maxHealthValue = 5;
	public Transform minHealth, maxHealth;
	public float transitionDuration = 2f;

	//Jump Variables
	public float jumpHeight = 6f;
	public float fallModifier = 2f;

	//Vertical Movement
	public float moveSpeed = 5f;

	//Private Variables
	private Rigidbody rb;
	private float currentHealth;
	private bool runUpdate = false;
	private float transitionTimer = 0f;
	private float groundedHeight;
	private Vector3 prevPosition;
	private Vector3 targetPosition;
	private Vector3 Velocity = Vector3.zero;
	private Vector3 prevVel = Vector3.zero;
	private bool alive = true;

	//Camera Effects
	private Camera mainCamera;
	private CameraShake cameraShake;

	//Animation Variables
	private Animator animator;
	//	int A_upwardVelocity
	bool wasGrounded = true;

	//Controller Input
	private float vm;

	void OnEnable ()
	{
		rb = GetComponent<Rigidbody> ();
		AlterHealth (10);
		groundedHeight = rb.position.y;
		mainCamera = Camera.main;
		cameraShake = mainCamera.GetComponent<CameraShake> ();
		animator = GetComponent<Animator> ();

	}

	void Update ()
	{
		vm = Input.GetAxis ("Vertical");
		MovePosition (vm);

		if (Input.GetButtonDown ("Jump") && Grounded ()) {
			rb.AddForce (Vector3.up * jumpHeight, ForceMode.VelocityChange);
			wasGrounded = false;
		}

		if (rb.velocity.y < 0) {
			rb.velocity += Vector3.up * Physics2D.gravity.y * (fallModifier - 1) * Time.deltaTime;
			//rb.AddForce (Physics.gravity * fallModifier, ForceMode.VelocityChange);
		} else if (rb.velocity.y > 0 && !Input.GetButton ("Jump") && !Grounded ()) {
			Debug.Log ("applying modified gravity");
			rb.velocity += Vector3.up * Physics2D.gravity.y * (fallModifier - 1) * Time.deltaTime;
		}

		if (runUpdate) {
			//Update to target position
			transitionTimer += Time.deltaTime;
			UpdatePosition ();
		}
		animator.SetFloat ("Upward Velocity", rb.velocity.y);
		animator.SetBool ("Grounded", Grounded ());
		animator.SetBool ("InPeral", currentHealth <= 2);
	}

	//Enables update position if Update position is false, returns true if player still alive.
	public void AlterHealth (int amount)
	{
		if (!runUpdate) {
			float prevHealth = currentHealth;
			currentHealth = Mathf.Clamp (currentHealth + amount, 0, maxHealthValue);
			if (prevHealth != currentHealth) {
				if (amount < 0)
					animator.SetTrigger ("Stumble");
				runUpdate = true;
				transitionTimer = 0f;
				targetPosition = FindNextPosition (minHealth.position, maxHealth.position, currentHealth / maxHealthValue);
				prevPosition = rb.position;
			}
		}
		if (currentHealth > 2) {
			CancelInvoke ("ShakeCamera");
		}
		if (currentHealth == 2) {
			CancelInvoke ("ShakeCamera");
			InvokeRepeating ("ShakeCamera", .1f, .1f);
		}
		if (currentHealth == 1) {
			CancelInvoke ("ShakeCamera");
			InvokeRepeating ("ShakeCamera", .05f, .05f);
		}
		if (currentHealth <= 0) {
			CancelInvoke ("ShakeCamera");
			GameManager.gameManager.GameOver ();
		}

	}
		

	//Helper function returns vector at amount position between 2 vectors
	Vector3 FindNextPosition (Vector3 prev, Vector3 next, float amount)
	{
		prev = new Vector3 (prev.x, prev.y, rb.position.z);
		next = new Vector3 (next.x, next.y, rb.position.z);
		return Vector3.Lerp (prev, next, amount);
	}

	//Lerp Towards Target Position
	void UpdatePosition ()
	{
		rb.position = Vector3.MoveTowards (rb.position, targetPosition, moveSpeed * Time.deltaTime);
		if (rb.position == targetPosition) {
			runUpdate = false;
		}
	}

	Vector3 ApplyMove (float dir, Vector3 velocity)
	{
		Vector3 vel = new Vector3 (0, 0, dir * moveSpeed * Time.deltaTime);
		Vector3 next = rb.position + vel;
		velocity += next - rb.position;
		return velocity;
	}

	Vector3 ApplyGravity (Vector3 gravity, float Scale, float prev, Vector3 velocity)
	{
		Vector3 next = gravity * Scale;
		Debug.Log ("Gravity scale and time" + next);
		next += Vector3.up * prev;
		Debug.Log ("After prev vel" + next);
		velocity += next * Time.deltaTime;
		return velocity;
	}

	void MovePosition (Vector3 velocity)
	{
		Vector3 next = rb.position + velocity;
		next.z = Mathf.Clamp (next.z, minHealth.position.z, maxHealth.position.z);
		rb.MovePosition (next);
	}

	void MovePosition (float dir)
	{
		Vector3 vel = new Vector3 (0, 0, dir * moveSpeed * Time.deltaTime);
		Vector3 next = rb.position + vel;
		next.z = Mathf.Clamp (next.z, minHealth.position.z, maxHealth.position.z);
		rb.MovePosition (next);
	}

	bool Grounded ()
	{
		RaycastHit hit;
		if (Physics.Raycast (rb.position, Vector3.down, out hit, 1f)) {
			return hit.transform.tag == "Ground";
		}
		return false;
	}

	void OnCollisionEnter (Collision other)
	{
		foreach (ContactPoint contact in other.contacts) {
			Obstacle obstacle = contact.otherCollider.GetComponent<Obstacle> ();
			if (obstacle != null) {
				AlterHealth (obstacle.GetObjDamage ());
				obstacle.Despawn (3);
				Rigidbody obsRB = obstacle.GetComponent<Rigidbody> ();
				obsRB.useGravity = true;
				obsRB.AddExplosionForce (10f, rb.position, 10f, 0, ForceMode.VelocityChange);
			}
		}
	}

	void ShakeCamera ()
	{
		cameraShake.tick ();
	}
}

