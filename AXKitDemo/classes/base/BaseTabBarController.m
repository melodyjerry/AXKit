//
//  BaseTabBarController.m
//  AXKit
//
//  Created by xaoxuu on 29/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "DefaultViewController.h"

@interface BaseTabBarController ()

// @xaoxuu: child controllers
@property (strong, nonatomic) NSArray<NSDictionary *> *controllers;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    for (NSDictionary *dict in self.controllers) {
        
        UIViewController *vc = UIViewControllerFromString(dict[@"vc"]) ?: services.app.defaultVC;
        BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
        [self setupChlidController:vc title:dict[@"title"] image:dict[@"icon"] selectedImage:dict[@"icon_sel"]];
    }
    
    [UITabBar appearance].barStyle = UIBarStyleDefault;
    [UITabBar appearance].translucent = NO;
    [UITabBar appearance].opaque = YES;
    [UITabBar appearance].barTintColor = axColor.white;
    [UITabBar appearance].tintColor = axColor.theme;
    
    self.tabBar.layer.ax_shadow(AXShadowUpLight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tabBar ax_removeSeparator];
}

- (NSArray<NSDictionary *> *)controllers{
    if (!_controllers) {
        _controllers = @"tabbar_controllers".mainBundlePath.readJson;
    }
    return _controllers;
}


// setup child controllers
- (void)setupChlidController:(UIViewController * __nonnull)vc title:(NSString * __nullable)title image:(NSString * __nonnull)image selectedImage:(NSString * __nullable)selectedImage {
    if (vc) {
        vc.title = NSLocalizedString(title, nil);
        if (image.length) {
            vc.tabBarItem.image = [UIImage imageNamed:image];
            if (selectedImage) {
                vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
            }
        }
    }
}



@end
