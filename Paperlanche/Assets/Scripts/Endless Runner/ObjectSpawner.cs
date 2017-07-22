using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectSpawner : MonoBehaviour
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
		int randIndex = (int)Random.Range (0, obstaclePrefabs.Length);
		GameObject spawnObject = obstaclePrefabs [randIndex];
		Instantiate (spawnObject, spawnLocation.position, Quaternion.identity, this.transform);
	}

}
