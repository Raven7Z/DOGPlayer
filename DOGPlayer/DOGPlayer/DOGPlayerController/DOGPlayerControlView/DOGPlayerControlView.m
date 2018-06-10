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
#import "DOGPlayerDunkerViewProtocol.h"

static const NSInteger kDunkerViewHeight = 36;
static const CGFloat kPlayButtonWidth = 61.5;
static const CGFloat kPlayButtonHeight = 61.5;

@interface DOGPlayerControlView ()
<
DOGPlayerDunkerViewProtocol
>

@property (nonatomic, strong) DOGPlayerDunkerView *dunkerView;

/**
 video play or stop control button
 */
@property (nonatomic, strong) DOGPlayerPlayButton *playButton;

/**
 controlview once touch can show or hidden controlview
 */
@property (nonatomic, strong) UITapGestureRecognizer *tapOnceGesture;

@end

@implementation DOGPlayerControlView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dunkerView];
        [self addSubview:self.playButton];
        [self addGestureRecognizer:self.tapOnceGesture];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat y = self.dog_Height -kDunkerViewHeight;
    _dunkerView.frame = CGRectMake(0, y, self.dog_Width, kDunkerViewHeight);
    _playButton.center = self.center;
}

#pragma mark - DOGPlayerDunkerViewProtocol
- (void)dunkerViewFullButtonClicked {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerControlViewProtocol)] && [_delegate respondsToSelector:@selector(playerControlViewFullButtonAction)]) {
        [_delegate playerControlViewFullButtonAction];
    }
}

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewBegin:(DOGPlayerSliderView *)sliderView {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerDunkerViewProtocol)] && [_delegate respondsToSelector:@selector(dunkerView:sliderViewBegin:)]) {
        [_delegate dunkerView:dunkerView sliderViewBegin:sliderView];
    }
}

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewCancle:(DOGPlayerSliderView *)sliderView {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerDunkerViewProtocol)] && [_delegate respondsToSelector:@selector(dunkerView:sliderViewCancle:)]) {
        [_delegate dunkerView:dunkerView sliderViewCancle:sliderView];
    }
}

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewValueChanged:(DOGPlayerSliderView *)sliderView progress:(CGFloat)progress {
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerDunkerViewProtocol)] && [_delegate respondsToSelector:@selector(dunkerView:sliderViewValueChanged:progress:)]) {
        [_delegate dunkerView:dunkerView sliderViewValueChanged:sliderView progress:progress];
    }
}

#pragma mark - action
- (void)onPlayButtonSelected:(DOGPlayerPlayButton *)sender {
    sender.selected = !sender.selected;
    BOOL play = sender.selected;
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerControlViewProtocol)] && [_delegate respondsToSelector:@selector(playerControlView:videoPlay:)]) {
        [_delegate playerControlView:self videoPlay:!play];
    }
}

- (void)onTapOnceControllView:(UITapGestureRecognizer *)gesture {
    _dunkerView.hidden = !_dunkerView.isHidden;
    _playButton.hidden = !_playButton.isHidden;
    
    BOOL hidden = _dunkerView.isHidden;
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerControlViewProtocol)] && [_delegate respondsToSelector:@selector(playerControlView:hidden:)]) {
        [_delegate playerControlView:self hidden:hidden];
    }
}

#pragma mark - property
- (DOGPlayerDunkerView *)dunkerView {
    CGFloat y = self.dog_Height -kDunkerViewHeight;
    
    if (_dunkerView == nil) {
        _dunkerView = [[DOGPlayerDunkerView alloc] initWithFrame:CGRectMake(0, y, self.dog_Width, kDunkerViewHeight)];
        _dunkerView.delegate = self;
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

- (UITapGestureRecognizer *)tapOnceGesture {
    if (_tapOnceGesture == nil) {
        _tapOnceGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOnceControllView:)];
        _tapOnceGesture.numberOfTouchesRequired = 1;
    }
    return _tapOnceGesture;
}

@end
