//
//  DOGPlayerDunkerView.h
//  DOGPlayer
//
//  Created by butterfly on 22/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DOGPlayerDunkerViewProtocol.h"
#import "DOGPlayerDunkerProgressView.h"

@interface DOGPlayerDunkerView : UIView
<
DOGPlayerDunkerViewProtocol
>

@property (nonatomic, weak) id <DOGPlayerDunkerViewProtocol> delegate;

@property (nonatomic, readonly) DOGPlayerDunkerProgressView *dunkerProgressView;

/**
 current play time
 */
@property (nonatomic, assign) NSInteger currentTime;

/**
 video total time
 */
@property (nonatomic, assign) NSInteger totalTime;

/**
 current video play progress
 */
@property (nonatomic, assign) CGFloat currentPlayProgress;

/**
 current video buffer progress
 */
@property (nonatomic, assign) CGFloat currentBufferProgress;

@end
