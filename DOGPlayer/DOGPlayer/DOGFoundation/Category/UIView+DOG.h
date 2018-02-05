//
//  UIView+DOG.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DOG)

/**
 self.frame.origin.y
 */
@property (nonatomic, assign) CGFloat dog_Top;

/**
 self.frame.origin.y + self.frame.size.height
 */
@property (nonatomic, assign) CGFloat dog_Bottom;

/**
 self.frame.origin.x
 */
@property (nonatomic, assign) CGFloat dog_Left;

/**
 self.frame.origin.x + self.frame.size.width
 */
@property (nonatomic, assign) CGFloat dog_Right;

/**
 self.center.x
 */
@property (nonatomic, assign) CGFloat dog_CenterX;

/**
 self.center.y
 */
@property (nonatomic, assign) CGFloat dog_CenterY;

/**
 self.frame.size.width
 */
@property (nonatomic, assign) CGFloat dog_Width;

/**
 self.frame.size.height
 */
@property (nonatomic, assign) CGFloat dog_Height;

/**
 self.frame.origin
 */
@property (nonatomic, assign) CGPoint dog_Origin;

/**
 self.frame.size
 */
@property (nonatomic, assign) CGSize dog_Size;

@end
