//
//  DOGPlayerViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/20.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DOGPlayerViewProtocol <NSObject>

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

@end

typedef NS_ENUM(NSInteger, DOGPlayerViewStatus) {
    DOGPlayerViewStatusUnknown,
    DOGPlayerViewStatusReadyToPlay,
    DOGPlayerViewStatusFailed
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


@end