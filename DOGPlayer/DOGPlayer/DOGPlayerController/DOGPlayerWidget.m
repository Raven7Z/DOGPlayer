//
//  DOGPlayerWidget.m
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerWidget.h"
#import "DOGPlayerWidget+Rotation.h"

#import "DOGPlayerView.h"
#import "DOGPlayerControlView.h"
#import "DOGPlayerLoadingView.h"
#import "DOGPlayerSliderView.h"

#import "UIView+DOG.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static const CGFloat kLoadingDuration = 0.5;

@interface DOGPlayerWidget ()
<
DOGPlayerViewDelegate
,DOGPlayerSliderViewProtocol
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
        [notificationCenter addObserver:self selector:@selector(handleStatusBarOrientationDidChangeNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
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

- (void)endPlay {
    [_playerView stop];
}

#pragma mark - Notification
- (void)handleDeviceOrientationDidChangeNotification:(NSNotification *)notif {
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationPortraitUpsideDown:
            break;
        case UIDeviceOrientationLandscapeLeft: {
            [self handleRotationEvent:UIDeviceOrientationLandscapeLeft];
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            [self handleRotationEvent:UIDeviceOrientationLandscapeRight];
        }
            break;
        case UIDeviceOrientationPortrait: {
            [self handleRotationEvent:UIDeviceOrientationPortrait];
        }
            break;
        
        default:
            break;
    }
}

- (void)handleStatusBarOrientationDidChangeNotification:(NSNotification *)notif {
    
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(statusBarOrientation)) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 3/4);
        [self tabBarHidden:NO];
        
    } else {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self tabBarHidden:YES];
    }
    self.playerView.frame = self.frame;
    self.controlView.frame = self.frame;
}

#pragma mark - Delegate
#pragma mark - DOGPlayerViewDelegate
- (void)playerView:(DOGPlayerView *)playerView
            status:(DOGPlayerViewStatus)status {
    
    switch (status) {
        case DOGPlayerViewStatusUnknown:
            break;
        case DOGPlayerViewStatusReadyToPlay:
            break;
        case DOGPlayerViewStatusFailed:
            break;
        case DOGPlayerViewStatusBuffering:
            [self showLoadingView];
            break;
        case DOGPlayerViewStatusPause:
            break;
        case DOGPlayerViewStatusPlaying:
            [self removeLoadingView];
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

- (void)playerControlView:(DOGPlayerControlView *)controlView hidden:(BOOL)hidden {
    
}

- (void)playerControlViewFullButtonAction {
    
}

#pragma mark - DOGPlayerControlViewProtocol / DOGPlayerDunkerViewProtocol
- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewBegin:(DOGPlayerSliderView *)sliderView {
    _sliderViewType = sliderView.type;
}

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewCancle:(DOGPlayerSliderView *)sliderView {
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
    }];
}

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewValueChanged:(DOGPlayerSliderView *)sliderView progress:(CGFloat)progress {
    _sliderViewType = sliderView.type;
    _controlView.dunkerView.currentPlayProgress = progress;
}

- (CGFloat)playerViewDealPlaybackBufferEmptyDuration {
    return kLoadingDuration;
}

#pragma mark - privater method
- (void)showLoadingView {
    [self addSubview:self.loadingView];
}

- (void)removeLoadingView {
    [self.loadingView removeFromSuperview];
}

- (void)handleRotationEvent:(UIDeviceOrientation)deviceOrientation {
    UIInterfaceOrientation statusBarOrietation = UIInterfaceOrientationPortrait;
    
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeRight: {
            [UIApplication sharedApplication].statusBarHidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            statusBarOrietation = UIInterfaceOrientationLandscapeLeft;
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            [UIApplication sharedApplication].statusBarHidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            statusBarOrietation = UIInterfaceOrientationLandscapeRight;
        }
            break;
        default:
            break;
    }
    [[UIApplication sharedApplication] setStatusBarOrientation:statusBarOrietation animated:YES];
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
