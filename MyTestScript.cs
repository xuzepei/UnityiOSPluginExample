using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.SceneManagement;

public class MyTestScript : MonoBehaviour {

	public enum AdType
	{
        AdTypeBannerAds,
        AdTypeRectAds,
        AdTypeInterstitialAds,
        AdTypeCrosspromoAds,
        AdTypeRewardedAds,
        AdTypeNativeAds
    };
	
	public enum BannerAdPosition
	{
		kLayoutTopLeft = 0x000000A0,
		kLayoutTopCenter = 0x000000A1,
		kLayoutTopRight = 0x000000A2,
		kLayoutCenterLeft = 0x000000A3,
		kLayoutCenter = 0x000000A4,
		kLayoutCenterRight = 0x000000A5,

		kLayoutBottomLeft = 0x000000A6,
		kLayoutBottomCenter = 0x000000A7,
		kLayoutBottomRight = 0x000000A8
	};

	public Text m_textView;
	public Text m_adId;
	AdsManagerScript m_manager;
	int m_adType;
	bool m_isHidden = false;
	int m_index = (int)BannerAdPosition.kLayoutTopLeft;

	public Button m_preloadButon;
	public Button m_showButon;
	public Button m_hideButon;
	public Button m_removeButon;
	public Button m_poseButon;
	public Button m_backButon;

	// Use this for initialization
	void Start () {

		m_adType = PlayerPrefs.GetInt ("ad_type");
		m_textView = GameObject.Find("MessageText").GetComponent<Text>();
		m_textView.text = "???";

		m_manager = new AdsManagerScript();
		m_manager.SetGameObjectName ("Canvas");

		m_adId = GameObject.Find ("AdId").GetComponent<Text> ();
		m_adId.text = "AdId:" + m_manager.GetAdId (m_adType);

		m_preloadButon.onClick.AddListener (clickedPreloadButton);
		m_showButon.onClick.AddListener (clickedShowButton);
		m_hideButon.onClick.AddListener (clickedHideButton);
		m_removeButon.onClick.AddListener (clickedRemoveButton);
		m_poseButon.onClick.AddListener (clickedPositionButton);
		m_backButon.onClick.AddListener (clickedBackButton);

	}
	
	// Update is called once per frame
	void Update () {
	
	}
		
	//Button event
	void clickedPreloadButton (){
		print ("clickedPreloadButton");

		m_manager.PreloadAd(m_adType);
	}

	void clickedShowButton (){
		print ("clickedShowButton");

		m_manager.ShowAd (m_adType);
	}

	void clickedHideButton (){
		print ("clickedHideButton");
		m_isHidden = m_isHidden?false:true;

		m_manager.SetHidden (m_adType,m_isHidden);
	}

	void clickedRemoveButton (){
		print ("clickedRemoveButton");

		m_manager.RemoveAd (m_adType);
	}

	void clickedPositionButton (){
		print ("clickedPositionButton");

		if (m_index == (int)BannerAdPosition.kLayoutBottomRight)
			m_index = (int)BannerAdPosition.kLayoutTopLeft;

		m_manager.SetPosition (m_adType,m_index);

		m_index++;
	}

	void clickedBackButton ()
	{
		m_manager.RemoveAd (m_adType);
		SceneManager.LoadScene (0);
	}

	void UpdateAdId(string message)
	{
		
	}

	//Ads sdk delegate
	void OnAdsLoaded(string message)
	{
		m_textView.text = "OnAdsLoaded:\n" + message;

		//m_manager.ShowAd ((int)AdType.AdTypeBannerAds);
		//m_manager.SetPosition((int)AdType.AdTypeBannerAds,(int)BannerAdPosition.kLayoutBottomCenter);
	}

	void OnAdsFailed(string message)
	{
		m_textView.text = "OnAdsFailed:\n" + message;
	}

	void OnAdsCollapsed(string message)
	{
		m_textView.text = "OnAdsCollapsed:\n" + message;
	}

	void OnAdsExpanded(string message)
	{
		m_textView.text = "OnAdsExpanded:\n" + message;
	}

	void OnRewarded(string message)
	{
		m_textView.text = "OnRewarded:\n" + message;
	}
}
