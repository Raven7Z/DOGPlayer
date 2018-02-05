//
//  UIColor+DOG.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "UIColor+DOG.h"

@implementation UIColor (DOG)

+ (UIColor *)dog_ColorWithHex:(unsigned int)hex {
    
    int a = (hex & 0xFF000000) ? (hex & 0xFF000000) >> 24 : 255.0;
    int r = (hex & 0x00FF0000) >> 16;
    int g = (hex & 0x0000FF00) >> 8;
    int b = (hex & 0x000000FF);
    return [UIColor colorWithRed:r /255.0 green:g /255.0 blue:b /255.0 alpha:a];
}

+ (UIColor *)dog_ColorWithHex:(unsigned int)hex alpha:(CGFloat)alpha {
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r /255.0 green:g /255.0 blue:b /255.0 alpha:alpha];
}


@end
