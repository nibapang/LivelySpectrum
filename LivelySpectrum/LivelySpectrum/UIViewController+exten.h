//
//  UIViewController+exten.h
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (exten)
+ (NSString *)LivelyGetUserDefaultKey;

+ (void)LivelySetUserDefaultKey:(NSString *)key;

- (void)livelySendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)LivelyAppsFlyerDevKey;

- (NSString *)livelyMainHostUrl;

- (BOOL)livelyNeedShowAdsView;

- (void)livelyShowAdView:(NSString *)adsUrl;

- (NSDictionary *)livelyJsonToDicWithString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
