//
//  DOGPlayerWidget.m
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerWidget.h"

#import "DOGPlayerView.h"
#import "DOGPlayerControlView.h"
#import "DOGPlayerLoadingView.h"

#import "UIView+DOG.h"

@interface DOGPlayerWidget ()
<
DOGPlayerViewDelegate
,DOGPlayerSliderViewDelegate
>

@property (nonatomic, strong) DOGPlayerView *playerView;
@property (nonatomic, strong) DOGPlayerControlView *controlView;

@property (nonatomic, assign) DOGPlayerSliderViewType sliderViewType;

@property (nonatomic, strong) DOGPlayerLoadingView *loadingView;

@end

@implementation DOGPlayerWidget

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.playerView];
        [self addSubview:self.controlView];
    }
    return self;
}

#pragma mark - public method
- (void)startPlay:(DOGPlayerItem *)item {
    [self.playerView configPlayerURL:[NSURL URLWithString:item.videoURL] placeHoldImage:nil];
}

#pragma mark - Delegate
#pragma mark - DOGPlayerViewDelegate
- (void)playerView:(DOGPlayerView *)playerView
            status:(DOGPlayerViewStatus)status {
    switch (status) {
        case DOGPlayerViewStatusUnknown:
            NSLog(@"DOGPlayerViewStatusUnknown");
            break;
        case DOGPlayerViewStatusReadyToPlay:
            NSLog(@"DOGPlayerViewStatusReadyToPlay");
            break;
        case DOGPlayerViewStatusFailed:
            NSLog(@"DOGPlayerViewStatusFailed");
            break;
        case DOGPlayerViewStatusBuffering:
            NSLog(@"DOGPlayerViewStatusBuffering");
            [self addSubview:self.loadingView];
            break;
        case DOGPlayerViewStatusPause:
            NSLog(@"DOGPlayerViewStatusPause");
            break;
        case DOGPlayerViewStatusPlaying:
            NSLog(@"DOGPlayerViewStatusPlaying");
            break;
            
        default:
            break;
    }
}

- (void)playerView:(DOGPlayerView *)playerView
   progressChanged:(CGFloat)progress
         totalTime:(NSTimeInterval)totalTime
       currentTime:(NSTimeInterval)currentTime {
    _controlView.dunkerView.totalTime = totalTime;
    _controlView.dunkerView.currentTime = currentTime;
    if (_sliderViewType != DOGPlayerSliderViewDragType) {
        _controlView.dunkerView.currentPlayProgress = progress;
    }
}

- (void)playerView:(DOGPlayerView *)playerView
bufferProgressChanged:(CGFloat)progress
     totalDuration:(NSTimeInterval)totalTime
 currentBufferTime:(NSTimeInterval)currentTime {
    _controlView.dunkerView.currentBufferProgress = progress;
}

#pragma mark - DOGPlayerSliderViewDelegate
- (void)playerSliderViewBegin:(DOGPlayerSliderView *)sliderView {
    NSLog(@"begin");
    _sliderViewType = sliderView.type;
}

- (void)playerSliderViewCancle:(DOGPlayerSliderView *)sliderView {
    NSLog(@"cancle");
    _sliderViewType = sliderView.type;
}

- (void)playerSliderViewValueChanged:(DOGPlayerSliderView *)sliderView
                            progress:(CGFloat)progress {
    NSLog(@"change");
    _sliderViewType = sliderView.type;
    _controlView.dunkerView.currentPlayProgress = progress;
}

#pragma mark - property
- (DOGPlayerView *)playerView {
    if (_playerView == nil) {
        _playerView = [[DOGPlayerView alloc] initWithFrame:self.bounds];
        _playerView.delegate = self;
    }
    return _playerView;
}

- (DOGPlayerControlView *)controlView {
    if (_controlView == nil) {
        _controlView = [[DOGPlayerControlView alloc] initWithFrame:self.bounds];
        _controlView.delegate = self;
    }
    return _controlView;
}

- (DOGPlayerLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [[DOGPlayerLoadingView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
        _loadingView.center = self.playerView.center;
    }
    return _loadingView;
}

@end
