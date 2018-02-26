//
//  DOGPlayerViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/20.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 play status
 
 - DOGPlayerViewStatusUnknown: unknown
 - DOGPlayerViewStatusReadyToPlay: player ready to play video
 - DOGPlayerViewStatusFailed: play video failed
 - DOGPlayerViewStatusBuffering: now video is buffering
 - DOGPlayerViewStatusPause: video pause
 - DOGPlayerViewStatusPlaying: now video is playing
 - DOGPlayerViewStatusNone: init status
 - DOGPlayerViewStatusEnd: video play end
 */
typedef NS_ENUM(NSInteger, DOGPlayerViewStatus) {
    DOGPlayerViewStatusUnknown = 0,
    DOGPlayerViewStatusReadyToPlay,
    DOGPlayerViewStatusFailed,
    DOGPlayerViewStatusBuffering,
    DOGPlayerViewStatusPause,
    DOGPlayerViewStatusPlaying,
    DOGPlayerViewStatusNone,
    DOGPlayerViewStatusEnd
};

@class DOGPlayerView;

@protocol DOGPlayerViewDelegate <NSObject>

/**
 playerView play status
 
 @param playerView DOGPlayerView
 @param status player status during playing
 */
- (void)playerView:(DOGPlayerView *_Nonnull)playerView
            status:(DOGPlayerViewStatus)status;

/**
 playerView progress changed
 
 @param playerView DOGPlayerView
 @param progress changed value
 @param totalTime video total time
 @param currentTime current play time
 */
- (void)playerView:(DOGPlayerView *_Nonnull)playerView
   progressChanged:(CGFloat)progress
         totalTime:(NSTimeInterval)totalTime
       currentTime:(NSTimeInterval)currentTime;


/**
 playerView buffer progress changed
 
 @param playerView DOGPlayerView
 @param progress changed value
 @param totalTime video total time
 @param currentTime current buffer time
 */
- (void)playerView:(DOGPlayerView *_Nonnull)playerView
bufferProgressChanged:(CGFloat)progress
     totalDuration:(NSTimeInterval)totalTime
 currentBufferTime:(NSTimeInterval)currentTime;

/**
 when player buffer is empty, playerView loading duration
 
 @return loading duration
 */
- (NSTimeInterval)playerViewDealPlaybackBufferEmptyDuration;


@end

@protocol DOGPlayerViewProtocol <NSObject>

@property (nonatomic, weak) id <DOGPlayerViewDelegate> delegate;

/**
 set video URL

 @param url URL
 @param image UIImage
 */
- (void)configPlayerURL:(NSURL *_Nonnull)url
         placeHoldImage:(UIImage *_Nullable)image;

/**
 play a video at point time, finished value will turn to YES after completion

 @param second NSTimeInterval
 @param completionHandler finished / YES represet it's over
 */
- (void)configPlayerPoint:(NSTimeInterval)second
         completionHandler:(void (^_Nullable)(BOOL finished))completionHandler;


/**
 video play
 */
- (void)play;

/**
 video pause
 */
- (void)pause;

@end
