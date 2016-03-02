using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.SceneManagement;

public class HomeSceneScript : MonoBehaviour {

	public Button m_button0;
	public Button m_button1;
	public Button m_button2;
	public Button m_button3;
	public Button m_button4;
	public Button m_button5;

	// Use this for initialization
	void Start () {
	
		m_button0.onClick.AddListener(delegate{clickedButtonWithIndex(0);});
		m_button1.onClick.AddListener(delegate{clickedButtonWithIndex(1);});
		m_button2.onClick.AddListener(delegate{clickedButtonWithIndex(2);});
		m_button3.onClick.AddListener(delegate{clickedButtonWithIndex(3);});
		m_button4.onClick.AddListener(delegate{clickedButtonWithIndex(4);});
		m_button5.onClick.AddListener(delegate{clickedButtonWithIndex(5);});

	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void clickedButtonWithIndex(int index){
	
		//Application.LoadLevel (index);

		Debug.Log (string.Format("Index is {0}",index));

		PlayerPrefs.SetInt ("ad_type",index);
		PlayerPrefs.Save ();

		SceneManager.LoadScene (1);
	}
}
