//
//  FullWideButton.m
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FullWideButton.h"

static UIActivityIndicatorView *indicator;

@implementation FullWideButton


- (void)setupButton{
    [super setupButton];
    self.frame = CGRectMake(0, 0, kScreenW, kTabBarHeight);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, kScreenBottomSafeAreaHeight, 0);
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIColor *titleColor = axThemeManager.color.theme;
    if (axThemeManager.color.theme.isLightColor) {
        titleColor = axThemeManager.color.theme.dark;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    
    [self setTitle:@"" forState:UIControlStateDisabled];
    
    indicator = [UIActivityIndicatorView defaultIndicator];
}


- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    if (enabled) {
        [indicator stopAnimating];
    } else {
        [indicator addToView:self];
    }
}


@end
