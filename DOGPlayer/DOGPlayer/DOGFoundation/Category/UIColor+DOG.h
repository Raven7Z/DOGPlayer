//
//  UIColor+DOG.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DOG)

/**
 base HEX set color

 @param hex HEXvalue
 @return UIColor
 */
+ (UIColor *)dog_ColorWithHex:(unsigned int)hex;

/**
 base HEX & alpa set color

 @param hex HEXvalue
 @param alpha CGFloat
 @return UIColor
 */
+ (UIColor *)dog_ColorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

@end
