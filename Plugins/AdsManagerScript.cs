using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class AdsManagerScript {

	/* Interface to native implementation */

	[DllImport ("__Internal")]
	private static extern void _SetGameObjectName(string gameObjectName);

	[DllImport ("__Internal")]
	private static extern string _GetAdId(int adType);

	[DllImport ("__Internal")]
	private static extern void _PreloadAd(int adType);

	[DllImport ("__Internal")]
	private static extern void _PreloadAllAds();

	[DllImport ("__Internal")]
	private static extern void _ShowAd(int adType);

	[DllImport ("__Internal")]
	private static extern void _RemoveAd(int adType);

	[DllImport ("__Internal")]
	private static extern void _SetHidden (int adType, bool isHidden);

	[DllImport ("__Internal")]
	private static extern void _SetPosition (int adType, int positionType);

	public void SetGameObjectName(string gameObjectName) 
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_SetGameObjectName(gameObjectName);
	}

	public string GetAdId(int adType) 
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			return _GetAdId(adType);

		return "";
	}

	public void PreloadAd(int adType)
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_PreloadAd(adType);
	}

	public void PreloadAllAds()
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_PreloadAllAds();
	}

	public void ShowAd(int adType)
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_ShowAd(adType);
	}

	public void RemoveAd(int adType)
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_RemoveAd(adType);
	}

	public void SetHidden (int adType, bool isHidden)
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_SetHidden(adType, isHidden);
	}

	public void SetPosition (int adType, int positionType)
	{
		// Call plugin only when running on real device
		if (Application.platform != RuntimePlatform.OSXEditor)
			_SetPosition(adType, positionType);
	}

}
