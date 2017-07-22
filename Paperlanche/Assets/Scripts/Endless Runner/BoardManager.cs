using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoardManager : MonoBehaviour
{

	public GameObject BuildingSlab;
	public Vector3 offset;
	public int numSlabs = 5;

	private Vector3[] slots;
	private List<GameObject> BuildingSlabs;
	private Vector3 CurrentSpawnLocation;

	// Use this for initialization
	void Start ()
	{
		RepeatingBackground.setOffsetMultiplier (numSlabs);
		BuildingSlabs = new List<GameObject> ();
		CurrentSpawnLocation = Vector3.zero;
		for (int i = 0; i < numSlabs; i++) {
			GameObject CurrentBlock = Instantiate (BuildingSlab, CurrentSpawnLocation, Quaternion.identity, this.transform) as GameObject;
			CurrentBlock.AddComponent<ScrollingObject> ();
			Vector3 nextSpawnLocation = CurrentBlock.transform.position + offset;
			CurrentSpawnLocation = new Vector3 (nextSpawnLocation.x, nextSpawnLocation.y, nextSpawnLocation.z);
			BuildingSlabs.Add (CurrentBlock);
		}

	}
	
	// Update is called once per frame
	void Update ()
	{
		
	}

	public void Recycle (GameObject idleSlab)
	{
		Rigidbody idleRB = idleSlab.GetComponent<Rigidbody> ();
		idleRB.MovePosition (CurrentSpawnLocation + offset);
	}

}
