//
//  UIResponder+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 14/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIResponder+AXAdd.h"

static UIViewController *rootVC = nil;

@implementation UIViewController (AXResponderAdd)

+ (UIViewController *)rootViewController{
    return rootVC ?: UIWindow.mainWindow.rootViewController;
}

+ (void)setRootViewController:(UIViewController *)rootViewController {
    rootVC = rootViewController;
}

@end

@implementation UIWindow (AXResponderAdd)

+ (UIWindow *)mainWindow{
    UIResponder *appDelegate = (UIResponder *)UIApplication.sharedApplication.delegate;
    return (UIWindow *)[appDelegate valueForKey:@"window"];
}

@end

@implementation UIView (AXResponderAdd)

// find view's super controller
- (UIViewController *)controller{
    UIResponder *responder = self;
    while ((responder = responder.nextResponder)){
        if ([responder isKindOfClass: UIViewController.class])
            return (UIViewController *)responder;
    }
    return nil;
}

@end
