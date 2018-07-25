//
//  UIImageView+AXAdd.m
//  AXKit
//
//  Created by xaoxuu on 27/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIImageView+AXAdd.h"
#import "UIImage+AXAdd.h"


@implementation UIImageView (AXAdd)

+ (instancetype)imageViewWithImageNamed:(NSString *)imageNamed{
    return [[UIImageView alloc] initWithImage:UIImage.named(imageNamed)];
}

@end
