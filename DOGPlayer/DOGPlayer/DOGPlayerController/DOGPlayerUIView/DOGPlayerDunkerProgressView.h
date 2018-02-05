//
//  DOGPlayerDunkerProgressView.h
//  DOGPlayer
//
//  Created by butterfly on 22/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

/*
 player bottom progress view
 */

#import <UIKit/UIKit.h>

@interface DOGPlayerDunkerProgressView : UIView

/**
 current play progress
 */
@property (nonatomic, assign) CGFloat currentPlayProgress;

/**
 current buffer progress
 */
@property (nonatomic, assign) CGFloat currentBufferProgress;

@end
