//
//  UIView+DOG.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "UIView+DOG.h"

@implementation UIView (DOG)

- (CGFloat)dog_Top {
    return self.frame.origin.y;
}

- (void)setDog_Top:(CGFloat)dog_Top {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(dog_Top);
    self.frame = frame;
}

- (CGFloat)dog_Bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setDog_Bottom:(CGFloat)dog_Bottom {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(dog_Bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)dog_Left {
    return self.frame.origin.x;
}

- (void)setDog_Left:(CGFloat)dog_Left {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(dog_Left);
    self.frame = frame;
}

- (CGFloat)dog_Right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDog_Right:(CGFloat)dog_Right {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(dog_Right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)dog_CenterX {
    return self.center.x;
}

- (void)setDog_CenterX:(CGFloat)dog_CenterX {
    self.center = CGPointMake(ceilf(dog_CenterX), self.center.y);
}

- (CGFloat)dog_CenterY {
    return self.center.y;
}

- (void)setDog_CenterY:(CGFloat)dog_CenterY {
    self.center = CGPointMake(self.center.x, ceilf(dog_CenterY));
}

- (CGFloat)dog_Width {
    return self.frame.size.width;
}

- (void)setDog_Width:(CGFloat)dog_Width {
    CGRect frame = self.frame;
    frame.size.width = ceilf(dog_Width);
    self.frame = frame;
}

- (CGFloat)dog_Height {
    return self.frame.size.height;
}

- (void)setDog_Height:(CGFloat)dog_Height {
    CGRect frame = self.frame;
    frame.size.height = ceilf(dog_Height);
    self.frame = frame;
}

- (CGPoint)dog_Origin {
    return self.frame.origin;
}

- (void)setDog_Origin:(CGPoint)dog_Origin {
    CGRect frame = self.frame;
    frame.origin = dog_Origin;
    self.frame = frame;
}

- (CGSize)dog_Size {
    return self.frame.size;
}

- (void)setDog_Size:(CGSize)dog_Size {
    CGRect frame = self.frame;
    frame.size = dog_Size;
    self.frame = frame;
}

@end
