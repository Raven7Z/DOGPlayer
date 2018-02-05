//
//  DOGPlayerSliderView.m
//  DOGPlayer
//
//  Created by butterfly on 24/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerSliderView.h"

#import "UIView+DOG.h"
#import "UIColor+DOG.h"
#import "UIControl+DOG.h"

static const NSInteger kProgressViewHeight = 3;
static const NSInteger kSliderButtonNormalWidth = 10;
static const NSInteger kSliderButtonNormalHeight = 10;
static const NSInteger kSliderButtonDragWidth = 14;
static const NSInteger kSliderButtonDragHeight = 14;
static const CGFloat kSliderButtonAnimationDuration = 0.2;
#define SliderButtonHitEdgeInsets UIEdgeInsetsMake(-15, -15, -15, -15)

@interface DOGPlayerSliderView ()

/**
 current buffer progress view
 */
@property (nonatomic, strong) UIProgressView *currentBufferProgressView;

/**
 current slider progress view
 */
@property (nonatomic, strong) UIProgressView *currentSliderProgressView;

/**
 the control button
 */
@property (nonatomic, strong) UIButton *sliderButton;

/**
 sliderButton 's dog_CenterX changed by sliderProgress
 */
@property (nonatomic, assign, getter=isAutoMoving) BOOL autoMoving;

@end

@implementation DOGPlayerSliderView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.autoMoving = YES;
        [self addSubview:self.currentBufferProgressView];
        [self.currentBufferProgressView addSubview:self.currentSliderProgressView];
        [self addSubview:self.sliderButton];
    }
    return self;
}

#pragma mark - target
#pragma mark - Slider Action

/**
 slider begin

 @param sender UIButton
 */
- (void)sliderBegin:(UIButton *)sender {
    
    [self sliderButtonExtensionAnimation:sender];
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewBegin:)]) {
        [_delegate playerSliderViewBegin:self];
    }
}

/**
 button inside/outside drag

 @param sender UIButton
 @param event UIEvent
 */
- (void)sliderDrag:(UIButton *)sender
         withEvent:(UIEvent *)event {
    
    [self sliderButtonExtensionAnimation:sender];
    self.autoMoving = YES;

    UITouch *touch = [[event touchesForView:sender] anyObject];
    CGPoint location = [touch locationInView:_currentSliderProgressView];
    CGFloat fatherViewWidth = _currentSliderProgressView.dog_Width;
    if (location.x >= 0 && location.x <= fatherViewWidth) {

        self.currentSliderProgress = MAX(0.0, MIN(1.0, location.x / fatherViewWidth));
        if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewValueChanged:progress:)]) {
            [_delegate playerSliderViewValueChanged:self progress:self.currentSliderProgress];
        }
    }
}

/**
 slider cancle

 @param sender UIButton
 */
- (void)sliderEnd:(UIButton *)sender {
    
    [self sliderButtonShrinkAnimation:sender];
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewCancle:)]) {
        [_delegate playerSliderViewCancle:self];
    }
}

#pragma mark - privater method
- (void)sliderButtonExtensionAnimation:(UIButton *)sender {

    if (sender.layer.cornerRadius == kSliderButtonDragHeight /2) {
        return;
    }

    [UIView animateWithDuration:kSliderButtonAnimationDuration animations:^{
        CGRect currentFrame = sender.frame;
        CGFloat x = -kSliderButtonDragWidth /2  +_currentBufferProgressView.dog_Left +_currentSliderProgressView.dog_Width *self.currentSliderProgress;
        CGFloat y = -(kSliderButtonDragHeight -self.dog_Height) /2;
        currentFrame = CGRectMake(x, y, kSliderButtonDragWidth, kSliderButtonDragHeight);
        sender.layer.cornerRadius = kSliderButtonDragHeight /2;
        sender.frame = currentFrame;
    }];
}

- (void)sliderButtonShrinkAnimation:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    self.autoMoving = YES;
    [UIView animateWithDuration:kSliderButtonAnimationDuration animations:^{
        CGRect currentFrame = sender.frame;
        CGFloat x = -kSliderButtonNormalWidth /2 +_currentBufferProgressView.dog_Left +_currentSliderProgressView.dog_Width *self.currentSliderProgress;
        CGFloat y = -(kSliderButtonNormalHeight -self.dog_Height) /2;
        currentFrame = CGRectMake(x, y, kSliderButtonNormalWidth, kSliderButtonNormalHeight);
        sender.layer.cornerRadius = kSliderButtonNormalHeight /2;
        sender.frame = currentFrame;
    } completion:^(BOOL finished) {
        [weakSelf.sliderButton setDog_HitEdgeInsets:SliderButtonHitEdgeInsets];
    }];
}

#pragma mark - property
#pragma mark - setter
- (void)setCurrentSliderProgress:(CGFloat)currentSliderProgress {
    if (currentSliderProgress <= 0) {
        [_currentSliderProgressView setProgress:currentSliderProgress];
    } else {
        [_currentSliderProgressView setProgress:currentSliderProgress animated:YES];
        if (_sliderButton && currentSliderProgress > 0 && self.isAutoMoving) {
            _sliderButton.dog_CenterX = _currentSliderProgressView.dog_Width *currentSliderProgress +_currentBufferProgressView.dog_Left;
        }
    }
}

- (void)setCurrentBufferProgress:(CGFloat)currentBufferProgress {
    if (currentBufferProgress <= 0) {
        [_currentBufferProgressView setProgress:currentBufferProgress];
    } else {
        [_currentBufferProgressView setProgress:currentBufferProgress animated:YES];
    }
}

- (void)setAutoMoving:(BOOL)autoMoving {
    _autoMoving = autoMoving;
}

#pragma mark - getter
- (CGFloat)currentSliderProgress {
    return _currentSliderProgressView.progress;
}

- (CGFloat)currentBufferProgress {
    return _currentBufferProgressView.progress;
}

- (UIProgressView *)currentBufferProgressView {
    if (_currentBufferProgressView == nil) {
        NSInteger x = 8;
        NSInteger width = self.dog_Width -16;
        _currentBufferProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(x, 0, width, kProgressViewHeight)];
        _currentBufferProgressView.dog_CenterY = self.dog_CenterY;
        _currentBufferProgressView.progressTintColor = [UIColor dog_ColorWithHex:0xf5f5f5];
        _currentBufferProgressView.trackTintColor = [UIColor dog_ColorWithHex:0xffffff alpha:0.6];
        _currentBufferProgressView.layer.masksToBounds = YES;
        _currentBufferProgressView.clipsToBounds = YES;
        _currentBufferProgressView.layer.cornerRadius = self.dog_Height /2;
    }
    return _currentBufferProgressView;
}

- (UIProgressView *)currentSliderProgressView {
    if (_currentSliderProgressView == nil) {
        _currentSliderProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, _currentBufferProgressView.dog_Width, kProgressViewHeight)];
        _currentSliderProgressView.progressTintColor = [UIColor dog_ColorWithHex:0xffce00];
        _currentSliderProgressView.trackTintColor = [UIColor dog_ColorWithHex:0xffffff alpha:0];
        _currentSliderProgressView.layer.masksToBounds = YES;
        _currentSliderProgressView.clipsToBounds = YES;
        _currentSliderProgressView.layer.cornerRadius = _currentBufferProgressView.dog_Height /2;
    }
    return _currentSliderProgressView;
}

- (UIButton *)sliderButton {
    
    if (_sliderButton == nil) {
        _sliderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sliderButton.backgroundColor = [UIColor dog_ColorWithHex:0xffffff];
        CGFloat x = -kSliderButtonNormalWidth /2 +_currentBufferProgressView.dog_Left;
        CGFloat y = (kSliderButtonNormalHeight -self.dog_Height) /2;
        _sliderButton.frame = CGRectMake(x, -y, kSliderButtonNormalWidth, kSliderButtonNormalHeight);
        _sliderButton.layer.masksToBounds = YES;
        _sliderButton.layer.cornerRadius = kSliderButtonNormalHeight /2;
        [_sliderButton setDog_HitEdgeInsets:SliderButtonHitEdgeInsets];
        
        [_sliderButton addTarget:self action:@selector(sliderBegin:) forControlEvents:UIControlEventTouchDown];
        
        [_sliderButton addTarget:self action:@selector(sliderDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_sliderButton addTarget:self action:@selector(sliderDrag:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
        
        [_sliderButton addTarget:self action:@selector(sliderEnd:) forControlEvents:UIControlEventTouchCancel];
        
        [_sliderButton addTarget:self action:@selector(sliderEnd:) forControlEvents:UIControlEventTouchUpInside];
        
        [_sliderButton addTarget:self action:@selector(sliderEnd:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _sliderButton;
}

@end
