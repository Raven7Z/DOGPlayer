//
//  DOGPlayerView.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerView.h"

#import "UIColor+DOG.h"

#import "DOGPlayer.h"

static NSString *const kLoadedTimeRanges = @"loadedTimeRanges";
static NSString *const kPlaybackBufferEmpty = @"playbackBufferEmpty";
static NSString *const kPlaybackLikelyToKeepUp = @"playbackLikelyToKeepUp";
static NSString *const kStatus = @"status";

@interface DOGPlayerView ()

@property (nonatomic, assign) DOGPlayerViewStatus status;
@property (nonatomic, strong) DOGPlayer *player;

@property (nonatomic, strong) AVURLAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) NSURL *url;

/**
 current play time
 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/**
 video total time
 */
@property (nonatomic, assign) NSTimeInterval totalTime;

/**
 playerItem status buffering
 */
@property (nonatomic, assign, getter=isBuffering) BOOL buffering;

@end

@implementation DOGPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor dog_ColorWithHex:0x000000 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews {
    _playerLayer.frame = self.bounds;
}

#pragma mark - DOGPlayerProtocol
- (void)play {
    switch (_status) {
        case DOGPlayerViewStatusPause:
        case DOGPlayerViewStatusReadyToPlay:
            self.status = DOGPlayerViewStatusPlaying;
            break;
        case DOGPlayerViewStatusPlaying:
            break;
        case DOGPlayerViewStatusBuffering:
            break;
        default:
            self.status = DOGPlayerViewStatusPlaying;
            break;
    }
    
    if (_player == nil) {
        return;
    }
    [_player play];
}

- (void)pause {
    switch (_status) {
        case DOGPlayerViewStatusPlaying:
        case DOGPlayerViewStatusBuffering:
        case DOGPlayerViewStatusReadyToPlay:
            self.status = DOGPlayerViewStatusPause;
            break;
        case DOGPlayerViewStatusPause:
            break;
            
        default:
            break;
    }
    [_player pause];
}

#pragma mark - DOGPlayerViewProtocol
- (void)configPlayerURL:(NSURL *)url placeHoldImage:(UIImage * _Nullable)image {
    if (url == nil) {
        return;
    }
    _url = url;
    
    self.asset = [AVURLAsset assetWithURL:_url];
    self.playerItem = [AVPlayerItem playerItemWithAsset:_asset];
    self.player = [DOGPlayer playerWithPlayerItem:_playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    [self play];
}

- (void)configPlayerPoint:(NSTimeInterval)second completionHandler:(void (^)(BOOL))completionHandler {
    
    if (_player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        if (_status == DOGPlayerViewStatusPlaying) {
            [_player pause];
        }
        CGFloat totalDuration = CMTimeGetSeconds(_player.currentItem.duration);
        CMTime startTime = CMTimeMakeWithSeconds(second * totalDuration, _playerItem.currentTime.timescale);
        __weak typeof(self)weakSelf = self;
        [_player seekToTime:startTime completionHandler:^(BOOL finished) {
            if (completionHandler) {
                completionHandler(finished);
            }
            if (weakSelf == nil) {
                return ;
            }
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            
            if (!strongSelf.playerItem.isPlaybackLikelyToKeepUp) {
                strongSelf.status = DOGPlayerViewStatusBuffering;
            }
            else {
                strongSelf.status = DOGPlayerViewStatusPlaying;
            }
            
            if (finished) {
                [strongSelf.player play];
            }
        }];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (object == _player.currentItem) {
        if ([keyPath isEqualToString:kStatus]) {
            AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
            [self dealStatus:status];
        } else if ([keyPath isEqualToString:kLoadedTimeRanges]) {
            [self dealLoadedTimeRanges];
        } else if ([keyPath isEqualToString:kPlaybackBufferEmpty]) {
            [self dealPlaybackBufferEmpty];
        } else if ([keyPath isEqualToString:kPlaybackLikelyToKeepUp]) {
            [self dealPlaybackLikelyToKeepUp];
        }
    }
}

#pragma mark - privater method

- (void)dealStatus:(AVPlayerStatus)status {
    switch (status) {
        case AVPlayerStatusReadyToPlay: {
            self.status = DOGPlayerViewStatusReadyToPlay;
        }
            break;
        case AVPlayerStatusFailed: {
            self.status = DOGPlayerViewStatusFailed;
        }
            break;
        default:
            self.status = DOGPlayerViewStatusUnknown;
            break;
    }
}

/**
 calcuate video buffer progress
 */
- (void)dealLoadedTimeRanges {
    NSArray *loadedTimeRanges = [_player.currentItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;
    
    CGFloat totalDuration = CMTimeGetSeconds(_player.currentItem.duration);
    CGFloat bufferProgress = timeInterval / totalDuration;
    
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(DOGPlayerViewDelegate)] && [_delegate respondsToSelector:@selector(playerView:bufferProgressChanged:totalDuration:currentBufferTime:)]) {
        [_delegate playerView:self bufferProgressChanged:bufferProgress totalDuration:totalDuration currentBufferTime:timeInterval];
    }
}

- (void)dealPlaybackBufferEmpty {
    if (_playerItem.playbackBufferEmpty) {
        self.status = DOGPlayerViewStatusBuffering;

        if (self.isBuffering) {
            return;
        }
        self.buffering = YES;
        [_player pause];
        
        __weak typeof(self)weakSelf = self;
        NSTimeInterval duration = [_delegate playerViewDealPlaybackBufferEmptyDuration];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf == nil) {
                return ;
            }
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            
            [strongSelf.player play];
            strongSelf.buffering = NO;
            if (!strongSelf.player.currentItem.isPlaybackLikelyToKeepUp) {
                [strongSelf dealPlaybackBufferEmpty];
            }
        });
    }
}

- (void)dealPlaybackLikelyToKeepUp {
    if (_player.currentItem.isPlaybackLikelyToKeepUp && _status == DOGPlayerViewStatusBuffering) {
        self.status = DOGPlayerViewStatusPlaying;
    }
}

#pragma mark - property
#pragma mark - setter
- (void)setStatus:(DOGPlayerViewStatus)status {
    _status = status;
    if (_delegate != nil && [_delegate respondsToSelector:@selector(playerView:status:)] && [_delegate conformsToProtocol:@protocol(DOGPlayerViewDelegate)]) {
        [_delegate playerView:self status:status];
    }
}

- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    
    if (_playerItem != nil) {
        [_playerItem removeObserver:self forKeyPath:kStatus];
        [_playerItem removeObserver:self forKeyPath:kLoadedTimeRanges];
        [_playerItem removeObserver:self forKeyPath:kPlaybackBufferEmpty];
        [_playerItem removeObserver:self forKeyPath:kPlaybackLikelyToKeepUp];
        _playerItem = nil;
    }
    
    _playerItem = playerItem;
    
    [_playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:kPlaybackBufferEmpty options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:kPlaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setPlayer:(DOGPlayer *)player {
    if (_player != nil) {
        _player = nil;
    }
    _player = player;
    
    __weak typeof(self)weakSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:nil usingBlock:^(CMTime time) {
        if (weakSelf == nil) {
            return ;
        }
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        AVPlayerItem *currentItem = strongSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            strongSelf.currentTime = (NSTimeInterval)CMTimeGetSeconds([currentItem currentTime]);
            strongSelf.totalTime = (NSTimeInterval)currentItem.duration.value / (NSTimeInterval)currentItem.duration.timescale;
            CGFloat progress = MAX(0.0, MIN(1.0, strongSelf.currentTime / strongSelf.totalTime));
            if (strongSelf.delegate != nil && [strongSelf.delegate respondsToSelector:@selector(playerView:progressChanged:totalTime:currentTime:)] && [strongSelf.delegate conformsToProtocol:@protocol(DOGPlayerViewDelegate)]) {
                [strongSelf.delegate playerView:strongSelf
                              progressChanged:progress
                                    totalTime:strongSelf.totalTime
                                  currentTime:strongSelf.currentTime];
            }
        }
    }];
}

- (void)setPlayerLayer:(AVPlayerLayer *)playerLayer {
    if (_playerLayer != nil) {
        [_playerLayer removeFromSuperlayer];
        _playerLayer = nil;
    }
    _playerLayer = playerLayer;
    _playerLayer.frame = self.bounds;
    [self.layer addSublayer:_playerLayer];
}

@end
