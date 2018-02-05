//
//  UIControl+DOG.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/2/3.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "UIControl+DOG.h"

#import <objc/runtime.h>

@implementation UIControl (DOG)

@dynamic dog_HitEdgeInsets;

static const NSString *kDOGHitEdgeInsets = @"dog.hit.edge.insets";

- (void)setDog_HitEdgeInsets:(UIEdgeInsets)dog_HitEdgeInsets {
    
    NSValue *value = [NSValue value:&dog_HitEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &kDOGHitEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)dog_HitEdgeInsets {
    
    NSValue *value = objc_getAssociatedObject(self, &kDOGHitEdgeInsets);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if(UIEdgeInsetsEqualToEdgeInsets(self.dog_HitEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.dog_HitEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end
