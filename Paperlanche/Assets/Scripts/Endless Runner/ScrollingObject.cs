using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent (typeof(Rigidbody))]
public class ScrollingObject : MonoBehaviour
{
	Rigidbody rb;
	BoardManager bm;
	// Use this for initialization
	void Awake ()
	{
		rb = GetComponent<Rigidbody> ();
		bm = GetComponentInParent<BoardManager> ();
	}

	void Update ()
	{
		Vector3 next = transform.position + Vector3.left * GameManager.gameManager.scrollSpeed * Time.deltaTime;
		transform.position = next;

		/*	if (Vector3.Distance (Vector3.zero, rb.position) > respawnDist) {
			bm.Recycle (gameObject);
		}*/
	}

}
