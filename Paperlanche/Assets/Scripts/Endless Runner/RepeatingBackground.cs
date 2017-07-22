using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RepeatingBackground : MonoBehaviour
{
	private BoxCollider groundCollider;
	private float groundHorizontalLength;
	private static float offsetMultiplier;

	// Use this for initialization
	void Start ()
	{
		groundCollider = GetComponentInChildren<BoxCollider> ();
		groundHorizontalLength = groundCollider.size.x;

	}
	
	// Update is called once per frame
	void Update ()
	{
		if (transform.position.x < -groundHorizontalLength * 2) {
			RepositionBackground ();
		}
	}

	private void RepositionBackground ()
	{
		Vector3 groundOffset = new Vector3 (groundHorizontalLength * offsetMultiplier, 0);

		transform.position = transform.position + groundOffset;
	}

	public static void setOffsetMultiplier (float amount)
	{
		offsetMultiplier = amount;
	}
}
