using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DamageTrigger : MonoBehaviour
{
	Collider col;
	public int damage = 1;
	private Animator animator;

	void Start ()
	{
		col = GetComponent<Collider> ();
		col.isTrigger = true;
		Invoke ("Despawn", 8);
		animator = GetComponent<Animator> ();
	}


	void OnTriggerEnter (Collider Other)
	{
		if (Other.tag == "Player") {
			Debug.Log (Other.tag);
			Other.GetComponent<EndlessRunnerMovement> ().AlterHealth (damage);
			col.enabled = false;
			animator.SetTrigger ("Topple");
		}
	}

	void Despawn ()
	{
		Destroy (gameObject);
	}
}
