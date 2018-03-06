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

static const CGFloat kLoadingDuration = 0.5;

@interface DOGPlayerWidget ()
<
DOGPlayerViewDelegate
,DOGPlayerSliderViewDelegate
,DOGPlayerControlViewProtocol
>

@property (nonatomic, strong) UIView <DOGPlayerViewProtocol> *playerView;
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
        if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(handleDeviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public method
- (void)startPlay:(DOGPlayerItem *)item {
    [self.playerView configPlayerURL:[NSURL URLWithString:item.videoURL] placeHoldImage:nil];
}

#pragma mark - privater method
- (void)showLoadingView {
    [self addSubview:self.loadingView];
}

- (void)removeLoadingView {
    [self.loadingView removeFromSuperview];
}

- (void)handleRotationEvent:(UIDeviceOrientation)deviceOrientation {
    CGRect crossFrame = [_delegate configPlayerWidgetFrame:self];
    
    
    NSLog(@"");
}

#pragma mark - Notification
- (void)handleDeviceOrientationDidChangeNotification:(NSNotification *)notif {
    
    NSString *text = nil;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            text = @"UIDeviceOrientationFaceUp";
            break;
        case UIDeviceOrientationFaceDown:
            text = @"UIDeviceOrientationFaceDown";
            break;
        case UIDeviceOrientationUnknown:
            text = @"UIDeviceOrientationUnknown";
            break;
        case UIDeviceOrientationLandscapeLeft: {
            text = @"UIDeviceOrientationLandscapeLeft";
            [self handleRotationEvent:UIDeviceOrientationLandscapeLeft];
        }
            break;
        case UIDeviceOrientationLandscapeRight:
            text = @"UIDeviceOrientationLandscapeRight";
            [self handleRotationEvent:UIDeviceOrientationLandscapeRight];
            break;
        case UIDeviceOrientationPortrait:
            text = @"UIDeviceOrientationPortrait";
            [self handleRotationEvent:UIDeviceOrientationPortrait];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            text = @"UIDeviceOrientationPortraitUpsideDown";
            break;
        default:
            text = @"can't check";
            break;
    }
    NSLog(@"%@", text);
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
            [self showLoadingView];
            break;
        case DOGPlayerViewStatusPause:
            NSLog(@"DOGPlayerViewStatusPause");
            break;
        case DOGPlayerViewStatusPlaying:
            [self removeLoadingView];
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

#pragma mark - DOGPlayerControlViewProtocol
- (void)playerControlView:(DOGPlayerControlView *)controlView videoPlay:(BOOL)play {
    if (play) {
        [_playerView play];
    } else {
        [_playerView pause];
    }
}

#pragma mark - DOGPlayerSliderViewDelegate
- (void)playerSliderViewBegin:(DOGPlayerSliderView *)sliderView {
    
    NSLog(@"begin");
    _sliderViewType = sliderView.type;
}

- (void)playerSliderViewCancle:(DOGPlayerSliderView *)sliderView {
    
    NSLog(@"cancle");
    _sliderViewType = sliderView.type;
    __weak typeof(self)weakSelf = self;
    [_playerView configPlayerPoint:sliderView.currentSliderProgress completionHandler:^(BOOL finished) {
        if (weakSelf == nil) {
            return ;
        }
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        NSLog(@"finished status :%d, sliderProgress = %f", finished, sliderView.currentSliderProgress);
    }];
}

- (void)playerSliderViewValueChanged:(DOGPlayerSliderView *)sliderView
                            progress:(CGFloat)progress {
    
    NSLog(@"change");
    _sliderViewType = sliderView.type;
    _controlView.dunkerView.currentPlayProgress = progress;
}

- (CGFloat)playerViewDealPlaybackBufferEmptyDuration {
    return kLoadingDuration;
}

#pragma mark - property
- (UIView<DOGPlayerViewProtocol> *)playerView {
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
        _controlView.controlViewDelegate = self;
    }
    return _controlView;
}

- (DOGPlayerLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [[DOGPlayerLoadingView alloc] initWithFrame:CGRectMake(0, 0, 46, 46) duration:kLoadingDuration];
        _loadingView.center = self.playerView.center;
    }
    return _loadingView;
}

@end
