//
//  DOGPlayerDunkerViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/6/10.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOGPlayerSliderView;
@class DOGPlayerDunkerView;

@protocol DOGPlayerDunkerViewProtocol <NSObject>

@optional
- (void)dunkerViewFullButtonClicked;

- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewBegin:(DOGPlayerSliderView *)sliderView;
- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewCancle:(DOGPlayerSliderView *)sliderView;
- (void)dunkerView:(DOGPlayerDunkerView *)dunkerView sliderViewValueChanged:(DOGPlayerSliderView *)sliderView progress:(CGFloat)progress;

@end
