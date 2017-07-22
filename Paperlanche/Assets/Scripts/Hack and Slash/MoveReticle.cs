using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveReticle : MonoBehaviour
{

	Rigidbody rb;
	Camera mainCamera;
	float mouseObjOffset;

	// Use this for initialization
	void Start ()
	{
		mainCamera = Camera.main;
		rb = GetComponent<Rigidbody> ();
		mouseObjOffset = rb.position.y;
	}
	
	// Update is called once per frame
	void Update ()
	{
		Vector3 MouseOffset = new Vector3 (Input.mousePosition.x, Input.mousePosition.y, mouseObjOffset);
		rb.MovePosition (mainCamera.ScreenToWorldPoint (MouseOffset));
	}
}
