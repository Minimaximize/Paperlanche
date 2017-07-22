using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraShake : MonoBehaviour
{

	public float rangeX, rangeY;

	Vector3 homePosition;

	// Use this for initialization
	void Start ()
	{
		homePosition = transform.position;
	}
	
	// Update is called once per frame
	void Update ()
	{
		if (transform.position != homePosition) {
			transform.position = Vector3.MoveTowards (transform.position, homePosition, 1f);
		}
	}

	public void tick ()
	{
		Vector3 offset = new Vector3 (Random.Range (-rangeX, rangeX), Random.Range (-rangeY, rangeY));
		transform.position += offset;
	}
}
