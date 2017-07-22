using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerHitbox : MonoBehaviour
{

	private Collider col;
	private float duration = 0f;
	private int damage = 1;

	// Use this for initialization
	void Start ()
	{
		col = GetComponent<Collider> ();
		col.enabled = false;
	}
	
	// Update is called once per frame
	void Update ()
	{
		if (col.enabled) {
			duration -= Time.deltaTime;
		}
		if (duration <= 0) {
			col.enabled = false;
		}
	}

	public void EnableHitbox (float interactTime, int damageAmount)
	{
		duration = interactTime;
		damage = damageAmount;
		col.enabled = true;
	}

	void OnTriggerEnter (Collider other)
	{
//		if (other.GetComponent<damageableObject> () != null) {
//			
//		}
	}
}
