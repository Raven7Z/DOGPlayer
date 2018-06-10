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

#import "DOGPlayerSliderViewProtocol.h"

typedef NS_ENUM(NSInteger, DOGPlayerSliderViewType) {
    DOGPlayerSliderViewInitType,
    DOGPlayerSliderViewBeginType,
    DOGPlayerSliderViewDragType,
    DOGPlayerSliderViewCancleType
};

@interface DOGPlayerSliderView : UIView

@property (nonatomic, weak) id <DOGPlayerSliderViewProtocol> delegate;

/**
 current play progress value
 */
@property (nonatomic, assign) CGFloat currentSliderProgress;

/**
 current buffer progress value
 */
@property (nonatomic, assign) CGFloat currentBufferProgress;

/**
 current sliderView action status
 */
@property (nonatomic, assign) DOGPlayerSliderViewType type;

@end
