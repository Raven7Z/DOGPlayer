//
//  DOGPlayerSliderView.h
//  DOGPlayer
//
//  Created by butterfly on 24/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

/*
 Custom Slider Control
 */

#import <UIKit/UIKit.h>

#import "DOGPlayerControlViewProtocol.h"

@interface DOGPlayerSliderView : UIView

@property (nonatomic, weak) id <DOGPlayerSliderViewDelegate> delegate;

/**
 current play progress value
 */
@property (nonatomic, assign) CGFloat currentSliderProgress;

/**
 current buffer progress value
 */
@property (nonatomic, assign) CGFloat currentBufferProgress;

@end
