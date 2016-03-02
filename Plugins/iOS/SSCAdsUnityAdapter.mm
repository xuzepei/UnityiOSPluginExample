//
//  SSCAdsUnityAdapter.m
//  Unity-iPhone
//
//  Created by xuzepei on 16/1/19.
//
//

#import "SSCAdsUnityAdapter.h"
#import "AdsSdk.h"
#import "AdIdHelper.h"

char* cStringCopy(const char* string)
{
    if (string == NULL)
        return NULL;
    
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    
    return res;
}


@implementation SSCAdsUnityAdapter

+ (SSCAdsUnityAdapter*)getInstance
{
    static SSCAdsUnityAdapter* sharedInstance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        sharedInstance = [[SSCAdsUnityAdapter alloc] init];
        [[AdsSdk getInstance] setDelegate:sharedInstance];
    });
    
    return sharedInstance;
}

- (void)setGameObjectName:(char*)name
{
    if(name && strlen(name))
    {
        self.objectName = [NSString stringWithFormat:@"%s",name];
    }
}

- (const char*)getAdId:(int)adType
{

    NSString* adid = nil;
    switch (adType) {
        case AdTypeBannerAds:
            adid = [AdIdHelper sharedAdIdHelper].bannerId;
            break;
        case AdTypeRectAds:
            adid = [AdIdHelper sharedAdIdHelper].rectId;
            break;
        case AdTypeInterstitialAds:
            adid = [AdIdHelper sharedAdIdHelper].interstitialId;
            break;
        case AdTypeCrosspromoAds:
            adid = [AdIdHelper sharedAdIdHelper].crosspromoId;
            break;
        case AdTypeRewardedAds:
            adid = [AdIdHelper sharedAdIdHelper].rewardedId;
            break;
        case AdTypeNativeAds:
            adid = [AdIdHelper sharedAdIdHelper].nativeId;
            break;
        default:
            break;
    }
    
    if([adid length])
        return cStringCopy([adid UTF8String]);
    
    return cStringCopy("");
}

- (void)preloadAd:(int)adType
{
    [[AdsSdk getInstance] preloadAds:(AdsType)adType];
}

- (void)preloadAllAds
{
    [[AdsSdk getInstance] preloadAllAds];
}

- (void)showAd:(int)adType
{
    [[AdsSdk getInstance] showAds:(AdsType)adType];
}

- (void)removeAd:(int)adType
{
    [[AdsSdk getInstance] removeAds:(AdsType)adType];
}

- (void)setHidden:(int)adType isHidden:(bool)isHidden
{
    [[AdsSdk getInstance] setAds:(AdsType)adType visable:!isHidden];
}

- (void)setPosition:(int)adType positionType:(int)positionType
{
    switch (adType) {
        case AdTypeBannerAds:
        {
           typedef enum{
                   kLayoutTopLeft = 0x000000A0,
                   kLayoutTopCenter = 0x000000A1,
                   kLayoutTopRight = 0x000000A2,
           
                   kLayoutCenterLeft = 0x000000A3,
                   kLayoutCenter = 0x000000A4,
                   kLayoutCenterRight = 0x000000A5,
           
                   kLayoutBottomLeft = 0x000000A6,
                   kLayoutBottomCenter = 0x000000A7,
                   kLayoutBottomRight = 0x000000A8
            }LAYOUT_TYPE;
            
            BannerAdsPostion pos=BannerAdsPostionCustom;
            switch (positionType) {
                case kLayoutTopLeft:
                    pos=BannerAdsPostionTopLeft;
                    break;
                case kLayoutCenterLeft:
                    pos=BannerAdsPostionCenterLeft;
                    break;
                case kLayoutBottomLeft:
                    pos=BannerAdsPostionBottomLeft;
                    break;
                    
                case kLayoutTopCenter:
                    pos=BannerAdsPostionTopCenter;
                    break;
                case kLayoutCenter:
                    pos=BannerAdsPostionCenterCenter;
                    break;
                case kLayoutBottomCenter:
                    pos=BannerAdsPostionBottomCenter;
                    break;
                    
                case kLayoutTopRight:
                    pos=BannerAdsPostionTopRight;
                    break;
                case kLayoutCenterRight:
                    pos=BannerAdsPostionCenterRight;
                    break;
                case kLayoutBottomRight:
                    pos=BannerAdsPostionBottomRight;
                    break;
                default:
                    break;
            }
            
            [[BannerAdsManager getInstance] setPositionQuick:pos];
            break;
        }
        case AdTypeNativeAds:
            [[NativeAdsManager getInstance] layoutByType:positionType];
        default:
            break;
    }
}

- (const char*)getJsonString:(NSDictionary*)dictonary
{
    NSString *jsonString = nil;
    if(dictonary)
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictonary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    if([jsonString length])
    {
        return [jsonString UTF8String];
    }
    
    return "";
}

/* AdsSdkDelegate methods
 * In C# code, there should be some matched methods to them and named 'OnAdsLoaded','OnAdsFailed',
 * 'OnAdsClicked','OnAdsCollapsed','OnAdsExpanded','OnRewarded'
 *
 */


#pragma mark - AdsSdkDelegate

//Invoked when ad loaded successfully.
-(void)onAdsLoaded:(AdsType)adType
{
    static NSString *methodName = @"OnAdsLoaded";
    if([self.objectName length])
    {
        NSDictionary* dict = @{@"ad_type":[NSString stringWithFormat:@"%d",(int)adType]};
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

//Invoked when ad fail to load.
-(void)onAdsFailed:(NSError *)error adType:(AdsType)adType
{
    static NSString *methodName = @"OnAdsFailed";
    if([self.objectName length])
    {
        NSDictionary* dict = @{@"ad_type":[NSString stringWithFormat:@"%d",(int)adType]};
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

//Invoked when ad was tapped.
-(void)onAdsClicked:(AdsType)adType
{
    static NSString *methodName = @"OnAdsClicked";
    if([self.objectName length])
    {
        NSDictionary* dict = @{@"ad_type":[NSString stringWithFormat:@"%d",(int)adType]};
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

//Invoked when ad was removed or dismissed.
-(void)onAdsCollapsed:(AdsType)adType
{
    static NSString *methodName = @"OnAdsCollapsed";
    if([self.objectName length])
    {
        NSDictionary* dict = @{@"ad_type":[NSString stringWithFormat:@"%d",(int)adType]};
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

//Invoked when ad was showed.
-(void)onAdsExpanded:(AdsType)adType
{
    static NSString *methodName = @"OnAdsExpanded";
    if([self.objectName length])
    {
        NSDictionary* dict = @{@"ad_type":[NSString stringWithFormat:@"%d",(int)adType]};
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

//Invoked when rewarded ad was viewed.
-(void)onRewarded:(NSString *)itemName amount:(NSInteger)amount isSkiped:(BOOL)isSkipped
{
    static NSString *methodName = @"OnRewarded";
    if([self.objectName length])
    {
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        
        if([itemName length])
            [dict setObject:itemName forKey:@"item_name"];
        
        [dict setObject:[NSString stringWithFormat:@"%d",(int)amount] forKey:@"amount"];
        [dict setObject:[NSString stringWithFormat:@"%d",(int)isSkipped] forKey:@"isskipped"];
        
        UnitySendMessage([self.objectName UTF8String],[methodName UTF8String],[self getJsonString:dict]);
    }
}

@end

// When native code plugin is implemented in .mm / .cpp file, then functions
// should be surrounded with extern "C" block to conform C function naming rules
extern "C" {
    
    //To get ad id by type
    const char* _GetAdId(int adType)
    {
        return [[SSCAdsUnityAdapter getInstance] getAdId:adType];
    }
    
    //To set the name of game object for UnitySendMessage method
    void _SetGameObjectName (char* gameObjectName)
    {
        [[SSCAdsUnityAdapter getInstance] setGameObjectName:gameObjectName];
    }
    
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
    void _PreloadAd (int adType)
    {
        [[SSCAdsUnityAdapter getInstance] preloadAd:adType];
    }
    
    //To preload all types of ads
    void _PreloadAllAds ()
    {
        [[SSCAdsUnityAdapter getInstance] preloadAllAds];
    }
    
    //To show a type of ad
    void _ShowAd (int adType)
    {
        [[SSCAdsUnityAdapter getInstance] showAd:adType];
    }
    
    //To remove a type of ad
    void _RemoveAd (int adType)
    {
        [[SSCAdsUnityAdapter getInstance] removeAd:adType];
    }
    
    //To set a type of ad hidden or not, only support banner, rect and native ad.
    void _SetHidden (int adType, bool isHidden)
    {
        [[SSCAdsUnityAdapter getInstance] setHidden:adType isHidden:isHidden];
    }
    
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
    
    void _SetPosition (int adType, int positionType)
    {
        [[SSCAdsUnityAdapter getInstance] setPosition:adType positionType:positionType];
    }
}
