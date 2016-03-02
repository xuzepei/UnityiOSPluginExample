# The adapter class for Unity ios project using ads sdk

2016.1.22

##Instruction

---

###API：

####void _SetGameObjectName (char* gameObjectName)

* To set the name of game object for UnitySendMessage method
    

####void _PreloadAd (int adType)

     /* To preload the ad by type
     * @param: adType: int  the values base on the enumeration definition below,so can use 0~6 integer instead.
     * typedef NS_ENUM(NSInteger, AdsType){
     *            AdTypeBannerAds,
     *            AdTypeRectAds,
     *            AdTypeInterstitialAds,
     *            AdTypeCrosspromoAds,
     *            AdTypeRewardedAds,
     *            AdTypeNativeAds
     *            };
     */


####void _PreloadAllAds ()

* To preload all types of ads
    

####void _ShowAd (int adType) 

* To show a type of ad
    

####void _RemoveAd (int adType)

* To remove a type of ad
    

####void _SetHidden (int adType, bool isHidden)

* To set a type of ad hidden or not, only support banner, rect and native ad.
    

####void _SetPosition (int adType, int positionType)


    /* To set position of an ad, only support banner and native ad(native banner ad), using this method after ad showed.
     * @param: positionType: int  the values base on the enumeration definition below,so can use 160~168 integer instead.
     *
     *    typedef enum
     *        {
     *        kLayoutTopLeft = 0x000000A0,
     *        kLayoutTopCenter = 0x000000A1,
     *        kLayoutTopRight = 0x000000A2,
     *
     *       kLayoutCenterLeft = 0x000000A3,
     *        kLayoutCenter = 0x000000A4,
     *        kLayoutCenterRight = 0x000000A5,
     *
     *        kLayoutBottomLeft = 0x000000A6,
     *        kLayoutBottomCenter = 0x000000A7,
     *        kLayoutBottomRight = 0x000000A8
     *
     *        }LAYOUT_TYPE;
     */
    
    
    
### Delegate methods from AdsSdkDelegate：

***In C# code, there should be some matched methods to them and named 'OnAdsLoaded','OnAdsFailed',
'OnAdsClicked','OnAdsCollapsed','OnAdsExpanded','OnRewarded'***

####- (void)onAdsLoaded:(AdsType)adType 

* Invoked when ad loaded successfully.

####- (void)onAdsFailed:(NSError *)error adType:(AdsType)adType

* Invoked when ad fail to load.

####- (void)onAdsClicked:(AdsType)adType 

* Invoked when ad was tapped.

####- (void)onAdsCollapsed:(AdsType)adType

* Invoked when ad was removed or dismissed.

####- (void)onAdsExpanded:(AdsType)adType

* Invoked when ad was showed.

####- (void)onRewarded:(NSString *)itemName amount:(NSInteger)amount isSkiped:(BOOL)isSkipped

* Invoked when rewarded ad was viewed.


##Examples

---

[ssh://git@stash.stm.com:7999/cmc/component-unity-demo.git](ssh://git@stash.stm.com:7999/cmc/component-unity-demo.git)
