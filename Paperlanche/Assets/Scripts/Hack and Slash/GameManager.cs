using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
	//UI Variables
	public GameObject GameOverText;
	public Text scoreText;
	public Text HighScoreText;

	//paperlanche
	public Animator paperlancheAnimator;

	public static GameManager gameManager = null;
	public float scrollSpeed = 20f;
	private float originalScrollSpeed;
	public float increaseRate;
	public float increaseFrequency;
	private float CurrentScore;
	private int TopScore;
	private bool canScore = false;
	private bool wasReset = true;


	void Awake ()
	{
		if (gameManager == null) {
			gameManager = this;
			originalScrollSpeed = scrollSpeed;
			canScore = true;
		} else if (gameManager != this) {
			Destroy (gameObject);
		}
		DontDestroyOnLoad (gameObject);
	}

	void Update ()
	{
		if (wasReset) {
			SetUp ();
			wasReset = false;
		}
		if (canScore)
			scorePoints ();

		if (Input.GetKeyDown (KeyCode.R) && !canScore) {
			Reset ();
		}

		if (Input.GetKeyDown (KeyCode.Escape)) {
			Application.Quit ();
		}
	}

	public void Reset ()
	{
		scrollSpeed = originalScrollSpeed;
		canScore = true;
		wasReset = true;
		SceneManager.LoadScene (SceneManager.GetActiveScene ().buildIndex);
	}

	public void GameOver ()
	{
		canScore = false;
		GameOverText.SetActive (true);
		Debug.Log ("Your Score " + getScore ());
		Debug.Log ("Top Score " + getTopScore ());
		Invoke ("DestroyPlayer", 1);
		CancelInvoke ("IncreaseSpeed");
	}

	public void DestroyPlayer ()
	{
		GameObject controls = GameObject.FindGameObjectWithTag ("Player");
		Destroy (controls);
		scrollSpeed = 0f;
	}

	public void IncreaseSpeed ()
	{
		scrollSpeed += increaseRate;
	}

	public int getScore ()
	{
		return Mathf.FloorToInt (CurrentScore);
	}

	public int getTopScore ()
	{
		return TopScore;
	}

	public void scorePoints ()
	{
		CurrentScore += scrollSpeed * Time.deltaTime;
		if (Mathf.FloorToInt (CurrentScore) > TopScore) {
			TopScore = Mathf.FloorToInt (CurrentScore);
			HighScoreText.text = "High Score " + TopScore.ToString ();
		}
		scoreText.text = "Score " + Mathf.FloorToInt (CurrentScore).ToString ();

	}

	void SetUp ()
	{
		CurrentScore = 0;
		InvokeRepeating ("IncreaseSpeed", increaseFrequency, increaseFrequency);
		if (scoreText == null) {
			scoreText = GameObject.FindGameObjectWithTag ("Score").GetComponent<Text> ();
		}
		if (HighScoreText == null) {
			HighScoreText = GameObject.FindGameObjectWithTag ("Highscore").GetComponent<Text> ();

		}
		if (GameOverText == null) {
			GameOverText = GameObject.FindGameObjectWithTag ("GameOver");
		}
		HighScoreText.text = "High Score " + TopScore.ToString ();
		GameOverText.SetActive (false);
	}
}