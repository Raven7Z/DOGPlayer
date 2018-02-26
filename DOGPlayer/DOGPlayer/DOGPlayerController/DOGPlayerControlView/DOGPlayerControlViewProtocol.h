//
//  DOGPlayerControlViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/20.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOGPlayerControlView;

@protocol DOGPlayerControlViewProtocol <NSObject>

/**
 play button control video play or stop

 @param controlView DOGPlayerControlView
 @param play YES / play
 */
- (void)playerControlView:(DOGPlayerControlView *)controlView
                videoPlay:(BOOL)play;

@end

@class DOGPlayerSliderView;

@protocol DOGPlayerSliderViewDelegate <NSObject>

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
