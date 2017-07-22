using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Obstacle : MonoBehaviour
{
	[SerializeField]
	private int DamageValue = -1;

	public int GetObjDamage ()
	{
		return DamageValue;
	}

	public void Despawn (int time)
	{
		Invoke ("PoolObject", time);
	}

	void PoolObject ()
	{
		gameObject.SetActive (false);
	}
}
