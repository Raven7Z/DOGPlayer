//
//  DOGPlayerControlView.m
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerControlView.h"

#import "UIView+DOG.h"

static const NSInteger kDunkerViewHeight = 36;

@interface DOGPlayerControlView ()
<
DOGPlayerSliderViewDelegate
>

@property (nonatomic, strong) DOGPlayerDunkerView *dunkerView;

@end

@implementation DOGPlayerControlView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dunkerView];
    }
    return self;
}

#pragma mark - DOGPlayerSliderViewDelegate
- (void)playerSliderViewBegin:(DOGPlayerSliderView *)sliderView {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewBegin:)]) {
        [_delegate playerSliderViewBegin:sliderView];
    }
}

- (void)playerSliderViewCancle:(DOGPlayerSliderView *)sliderView {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewCancle:)]) {
        [_delegate playerSliderViewCancle:sliderView];
    }
}

- (void)playerSliderViewValueChanged:(DOGPlayerSliderView *)sliderView progress:(CGFloat)progress {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerSliderViewDelegate)] && [_delegate respondsToSelector:@selector(playerSliderViewValueChanged:progress:)]) {
        [_delegate playerSliderViewValueChanged:sliderView progress:progress];
    }
}

#pragma mark - property
- (DOGPlayerDunkerView *)dunkerView {
    CGFloat y = self.dog_Height -kDunkerViewHeight;
    
    if (_dunkerView == nil) {
        _dunkerView = [[DOGPlayerDunkerView alloc] initWithFrame:CGRectMake(0, y, self.dog_Width, kDunkerViewHeight)];
        _dunkerView.sliderView.delegate = self;
    }
    return _dunkerView;
}

@end
