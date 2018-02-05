//
//  DOGPlayerDunkerView.m
//  DOGPlayer
//
//  Created by butterfly on 22/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerDunkerView.h"

#import "DOGTool.h"

#import "UIView+DOG.h"
#import "UIColor+DOG.h"

static const NSInteger kDunkerProgressViewHeight = 2;

static const NSInteger kCurrentTimeLabelLeftMargin = 17;
static const NSInteger kCurrentTimeLabelBottomMargin = 12;

static const NSInteger kFullScreenButtonWidth = 16.5;

static const NSInteger kSliderViewHeight = 20;

@interface DOGPlayerDunkerView ()

@property (nonatomic, strong) DOGPlayerDunkerProgressView *dunkerProgressView;
@property (nonatomic, strong) DOGPlayerSliderView *sliderView;

@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UIButton *fullScreenButton;

@end

@implementation DOGPlayerDunkerView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.currentTimeLabel];
        [self addSubview:self.fullScreenButton];
        [self addSubview:self.totalTimeLabel];
        [self addSubview:self.sliderView];
    }
    return self;
}

#pragma mark - target
- (void)fullScreenButtonClickEvent:(UIButton *)sender {
    NSLog(@"full screen button");
}

#pragma mark - privater method

#pragma mark - property
#pragma mark - setter
- (void)setCurrentTime:(NSInteger)currentTime {
    _currentTime = currentTime;
    NSInteger currentMin = _currentTime / 60;
    NSInteger currentSec = _currentTime % 60;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", currentMin, currentSec];
}

- (void)setTotalTime:(NSInteger)totalTime {
    if (_totalTime == totalTime) {
        return;
    }
    _totalTime = totalTime;
    NSInteger totalMin = _totalTime / 60;
    NSInteger totalSec = _totalTime % 60;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", totalMin, totalSec];
}

- (void)setCurrentPlayProgress:(CGFloat)currentPlayProgress {
    _currentPlayProgress = currentPlayProgress;
    _sliderView.currentSliderProgress = currentPlayProgress;
}

- (void)setCurrentBufferProgress:(CGFloat)currentBufferProgress {
    _currentBufferProgress = currentBufferProgress;
    _sliderView.currentBufferProgress = currentBufferProgress;
}

#pragma mark - getter
- (UILabel *)currentTimeLabel {
    CGSize timeLabelSize = [DOGTool dog_CalculateSizeOfNormalText:@"00:00" font:13 width:self.dog_Width fontWithName:nil];
    CGFloat x = kCurrentTimeLabelLeftMargin;
    CGFloat y = self.dog_Height -kCurrentTimeLabelBottomMargin -timeLabelSize.height;
    CGFloat width = timeLabelSize.width;
    CGFloat height = timeLabelSize.height;
    
    if (_currentTimeLabel == nil) {
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.font = [UIFont systemFontOfSize:13];
        _currentTimeLabel.textColor = [UIColor dog_ColorWithHex:0xffffff];
        _currentTimeLabel.numberOfLines = 1;
        _currentTimeLabel.adjustsFontSizeToFitWidth = YES;
        _currentTimeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _currentTimeLabel;
}

- (DOGPlayerSliderView *)sliderView {
    CGFloat x = _currentTimeLabel.dog_Right;
    CGFloat height = kSliderViewHeight;
    CGFloat y = 0;
    CGFloat width = self.dog_Width -_currentTimeLabel.dog_Right-_totalTimeLabel.dog_Width -20 -_fullScreenButton.dog_Width -17;
    
    if (_sliderView == nil) {
        _sliderView = [[DOGPlayerSliderView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _sliderView.dog_CenterY = _currentTimeLabel.dog_CenterY;
    }
    return _sliderView;
}

- (UILabel *)totalTimeLabel {
    CGSize totalTimeLabelSize = [DOGTool dog_CalculateSizeOfNormalText:@"00:00" font:13 width:self.dog_Width fontWithName:nil];
    CGFloat x = _fullScreenButton.dog_Left -20 -totalTimeLabelSize.width;
    CGFloat y = _currentTimeLabel.dog_Top;
    CGFloat width = totalTimeLabelSize.width;
    CGFloat height = totalTimeLabelSize.height;
    
    if (_totalTimeLabel == nil) {
        _totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _totalTimeLabel.text = @"00:00";
        _totalTimeLabel.font = [UIFont systemFontOfSize:13];
        _totalTimeLabel.textColor = [UIColor dog_ColorWithHex:0xffffff];
        _totalTimeLabel.numberOfLines = 1;
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _totalTimeLabel;
}

- (UIButton *)fullScreenButton {
    CGFloat x = self.dog_Width -kFullScreenButtonWidth -17;
    CGFloat y = _currentTimeLabel.dog_CenterY - kFullScreenButtonWidth /2;
    CGFloat width = kFullScreenButtonWidth;
    CGFloat height = kFullScreenButtonWidth;
    
    if (_fullScreenButton == nil) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullScreenButton.frame = CGRectMake(x, y, width, height);
        [_fullScreenButton setImage:[UIImage imageNamed:@"dog_full_screen"] forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

- (DOGPlayerDunkerProgressView *)dunkerProgressView {
    if (_dunkerProgressView == nil) {
        _dunkerProgressView = [[DOGPlayerDunkerProgressView alloc] initWithFrame:CGRectMake(0, self.dog_Height -kDunkerProgressViewHeight, self.dog_Width, kDunkerProgressViewHeight)];
    }
    return _dunkerProgressView;
}

@end
