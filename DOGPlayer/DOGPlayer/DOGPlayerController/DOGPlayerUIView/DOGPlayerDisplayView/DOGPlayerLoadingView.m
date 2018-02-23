//
//  DOGPlayerLoadingView.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/2/13.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerLoadingView.h"

#import "UIView+DOG.h"

static NSString *const kLoadingViewGroupAnimation = @"loadingView.group.animation";

@interface DOGPlayerLoadingView ()

@property (nonatomic, strong) CAShapeLayer *loadingLayer;

/**
 loading duration
 */
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation DOGPlayerLoadingView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _duration = duration;
        [self.layer addSublayer:self.loadingLayer];
        [self startLoading];
    }
    return self;
}

#pragma mark - public method
- (void)startLoading {
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    animationGroup.duration = _duration;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self.loadingLayer addAnimation:animationGroup forKey:kLoadingViewGroupAnimation];
}

- (void)endLoading {
    [self.loadingLayer removeAnimationForKey:kLoadingViewGroupAnimation];
    
}

#pragma mark - property
- (CAShapeLayer *)loadingLayer {
    if (_loadingLayer == nil) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.strokeColor = [UIColor whiteColor].CGColor;
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.lineWidth = 3.0f;
        _loadingLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:self.dog_Width /2].CGPath;
    }
    return _loadingLayer;
}


@end
