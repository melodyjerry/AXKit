//
//  UIApplication+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 10/10/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIApplication+AXAdd.h"
#import <SafariServices/SafariServices.h>
#import "UIResponder+AXAdd.h"


/**
 获取跳转的URLString

 @param key key
 @return 跳转的URLString
 */
static inline NSString *urlStringWithKey(NSString *key){
    if (@available(iOS 10.0, *)) {
        // on newer versions
        return [NSString stringWithFormat:@"App-Prefs:root=%@", key];
    } else {
        // Fallback on earlier versions
        return [NSString stringWithFormat:@"Prefs:root=%@", key];
    }
}

/**
 跳转到指定URLString

 @param urlString URLString
 @param completionHandler 完成回调（只有iOS10及其之后的版本可用）
 */
static inline void openSettingURLWithString(NSString *urlString, void(^ __nullable completionHandler)(BOOL success)){
    NSURL *url = [NSURL URLWithString:urlString];
    if (@available(iOS 10.0, *)) {
        // on newer versions
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:completionHandler];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:url];
    }
}

@implementation UIApplication (AXExtension)


+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL{
    [self ax_presentSafariViewControllerWithURL:URL fromViewController:nil completion:nil];
}
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL completion:(void (^)(void))completion{
    [self ax_presentSafariViewControllerWithURL:URL fromViewController:nil completion:completion];
}
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL fromViewController:(UIViewController *)viewController{
    [self ax_presentSafariViewControllerWithURL:URL fromViewController:viewController completion:nil];
}
+ (void)ax_presentSafariViewControllerWithURL:(NSURL *)URL fromViewController:(UIViewController *)viewController completion:(void (^)(void))completion{
    if (@available(iOS 9.0, *)) {
        // on newer versions
        SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL];
        [viewController?:UIViewController.rootViewController presentViewController:safari animated:YES completion:completion];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:URL];
    }
}

#pragma mark - 跳转

/**
 打开蓝牙设置
 */
+ (void)ax_openBluetoothSetting{
    openSettingURLWithString(urlStringWithKey(@"Bluetooth"), nil);
}

/**
 打开WIFI设置
 */
+ (void)ax_openWIFISetting{
    openSettingURLWithString(urlStringWithKey(@"WIFI"), nil);
}

/**
 打开通知设置
 */
+ (void)ax_openNotificationSetting{
    openSettingURLWithString(urlStringWithKey(@"NOTIFICATIONS_ID"), nil);
}
/**
 打开相册设置
 */
+ (void)ax_openPhotosSetting{
    openSettingURLWithString(urlStringWithKey(@"Photos"), nil);
}

/**
 打开浏览器设置
 */
+ (void)ax_openSafariSetting{
    openSettingURLWithString(urlStringWithKey(@"SAFARI"), nil);
}

/**
 打开当前app的设置页面
 */
+ (void)ax_openAppSetting:(void (^)(BOOL))completion{
    openSettingURLWithString(UIApplicationOpenSettingsURLString, completion);
}


@end
