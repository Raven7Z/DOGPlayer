//
//  DOGPlayerControlView.m
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerControlView.h"

#import "UIView+DOG.h"

#import "DOGPlayerPlayButton.h"

static const NSInteger kDunkerViewHeight = 36;
static const CGFloat kPlayButtonWidth = 61.5;
static const CGFloat kPlayButtonHeight = 61.5;

@interface DOGPlayerControlView ()
<
DOGPlayerSliderViewDelegate
>

@property (nonatomic, strong) DOGPlayerDunkerView *dunkerView;

/**
 video play or stop control button
 */
@property (nonatomic, strong) DOGPlayerPlayButton *playButton;

@end

@implementation DOGPlayerControlView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dunkerView];
        [self addSubview:self.playButton];
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

#pragma mark - target
- (void)onPlayButtonSelected:(DOGPlayerPlayButton *)sender {
    sender.selected = !sender.selected;
    BOOL play = sender.selected;
    if (_controlViewDelegate != nil && [_controlViewDelegate conformsToProtocol:@protocol(DOGPlayerControlViewProtocol)] && [_controlViewDelegate respondsToSelector:@selector(playerControlView:videoPlay:)]) {
        [_controlViewDelegate playerControlView:self videoPlay:!play];
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

- (DOGPlayerPlayButton *)playButton {
    if (_playButton == nil) {
        _playButton = [DOGPlayerPlayButton dogPlayerPlayButtonWithType:UIButtonTypeCustom];
        _playButton.frame = CGRectMake(0, 0, kPlayButtonWidth, kPlayButtonHeight);
        _playButton.center = self.center;
        [_playButton addTarget:self action:@selector(onPlayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end
