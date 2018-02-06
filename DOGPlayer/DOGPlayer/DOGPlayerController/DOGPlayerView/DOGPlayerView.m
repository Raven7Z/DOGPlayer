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

@interface DOGPlayerView ()

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

@end

@implementation DOGPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor dog_ColorWithHex:0x000000 alpha:1.0];
    }
    return self;
}

#pragma mark - privater method

#pragma mark - DOGPlayerProtocol
- (void)play {
    if (_player == nil) {
        return;
    }
    [_player play];
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
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (object == _player.currentItem) {
        if ([keyPath isEqualToString:@"status"]) {
            DOGPlayerViewStatus status = [[change objectForKey:@"new"] intValue];
            
            if (_delegate != nil && [_delegate respondsToSelector:@selector(playerView:status:)] && [_delegate conformsToProtocol:@protocol(DOGPlayerViewDelegate)]) {
                [_delegate playerView:self status:status];
            }
        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            
        }
    }
}

#pragma mark - property

- (void)setPlayerItem:(AVPlayerItem *)playerItem {
    
    if (_playerItem != nil) {
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        _playerItem = nil;
    }
    
    _playerItem = playerItem;
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setPlayer:(DOGPlayer *)player {
    if (_player != nil) {
        _player = nil;
    }
    _player = player;
    
    __weak typeof(self)weakSelf = self;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:nil usingBlock:^(CMTime time) {
        AVPlayerItem *currentItem = weakSelf.playerItem;
        NSArray *loadedRanges = currentItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && currentItem.duration.timescale != 0) {
            weakSelf.currentTime = (NSTimeInterval)CMTimeGetSeconds([currentItem currentTime]);
            weakSelf.totalTime = (NSTimeInterval)currentItem.duration.value / (NSTimeInterval)currentItem.duration.timescale;
            CGFloat progress = MAX(0.0, MIN(1.0, weakSelf.currentTime / weakSelf.totalTime));
            if (weakSelf.delegate != nil && [weakSelf.delegate respondsToSelector:@selector(playerView:progressChanged:totalTime:currentTime:)] && [weakSelf.delegate conformsToProtocol:@protocol(DOGPlayerViewDelegate)]) {
                [weakSelf.delegate playerView:weakSelf
                              progressChanged:progress
                                    totalTime:weakSelf.totalTime
                                  currentTime:weakSelf.currentTime];
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