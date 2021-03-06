using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectSpawnerOG : MonoBehaviour
{

	public int cabinetPoolSize = 10;
	public GameObject[] obstaclePrefabs;
	public float spawnRate;
	public Transform spawnLocation;

	private GameObject[] obstacles;
	private float SpawnCountdown;

	// Use this for initialization
	void Start ()
	{
		obstacles = new GameObject[cabinetPoolSize];
		for (int i = 0; i < cabinetPoolSize; i++) {
			obstacles [i] = Instantiate (obstaclePrefabs [Random.Range (0, obstaclePrefabs.Length)], this.transform);
			obstacles [i].SetActive (false);
		}
		InvokeRepeating ("Spawn", spawnRate, spawnRate);
	}
	
	// Update is called once per frame
	void Update ()
	{
		
	}

	void Spawn ()
	{
		for (int i = 0; i < cabinetPoolSize; i++) {
			if (!obstacles [i].activeInHierarchy) {
				//obstacles [i].transform.position = spawnLocation;
				obstacles [i].SetActive (true);
				Rigidbody objRB = obstacles [i].GetComponent<Rigidbody> ();
				objRB.useGravity = false;
				objRB.rotation = Quaternion.identity;
				objRB.velocity = Vector3.left * 5f;
				objRB.angularVelocity = Vector3.zero;

				break;
			}
		}
	}

}
