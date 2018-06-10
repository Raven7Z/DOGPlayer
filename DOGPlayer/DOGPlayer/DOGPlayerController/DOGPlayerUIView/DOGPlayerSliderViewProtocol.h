//
//  DOGPlayerSliderViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/6/10.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOGPlayerSliderView;

@protocol DOGPlayerSliderViewProtocol <NSObject>

@optional
/**
 slider change progress value
 
 @param sliderView DOGPlayerSliderView
 @param progress value
 */
- (void)playerSliderViewValueChanged:(DOGPlayerSliderView *)sliderView
                            progress:(CGFloat)progress;

/**
 slider Begin drag
 
 @param sliderView DOGPlayerSliderView
 */
- (void)playerSliderViewBegin:(DOGPlayerSliderView *)sliderView;

/**
 slider cancle
 
 @param sliderView DOGPlayerSliderView
 */
- (void)playerSliderViewCancle:(DOGPlayerSliderView *)sliderView;

@end
