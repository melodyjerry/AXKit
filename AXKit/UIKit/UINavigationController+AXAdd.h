//
//  UINavigationController+AXAdd.h
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UINavigationController (AXAdd)

/**
 push到指定name的控制器，animated为YES
 
 @param vcName VC的name
 */
- (void)ax_pushViewControllerNamed:(NSString *)vcName;
/**
 push到指定name的控制器，animated为YES
 */
- (void (^)(NSString *name))pushViewControllerNamed;

- (void (^)(UIViewController *))pushViewController;

/**
 push到指定name的控制器
 
 @param vcName VC的name
 @param animated 是否显示动画
 @param completion 完成后的回调
 @param failure 失败时的错误信息（不存在或者self不属于NavController）
 */
- (void)ax_pushViewControllerNamed:(NSString *)vcName animated:(BOOL)animated completion:(void (^)(UIViewController *targetVC))completion failure:(void (^)(NSError *error))failure;

/**
 pop到指定viewController

 @param index 从rootVC开始向后数的index，rootVC为0
 @param animated 是否显示动画
 */
- (void)ax_popToViewControllerWithIndexFromRoot:(NSUInteger)index animated:(BOOL)animated;

/**
 pop到指定viewController

 @param index 从当前viewController开始向前数的index，当前VC为0
 @param animated 是否显示动画
 */
- (void)ax_popToViewControllerWithIndexFromSelf:(NSUInteger)index animated:(BOOL)animated;

@end
NS_ASSUME_NONNULL_END
