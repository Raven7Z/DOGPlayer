//
//  DOGPlayerDunkerProgressView.m
//  DOGPlayer
//
//  Created by butterfly on 22/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerDunkerProgressView.h"

#import "UIColor+DOG.h"
#import "UIView+DOG.h"

@interface DOGPlayerDunkerProgressView ()

@property (nonatomic, strong) UIProgressView *currentPlayProgressView;
@property (nonatomic, strong) UIProgressView *currentBufferProgressView;

@end

@implementation DOGPlayerDunkerProgressView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor dog_ColorWithHex:0xf5f5f5];
        
        [self addSubview:self.currentBufferProgressView];
        [self addSubview:self.currentPlayProgressView];
    }
    return self;
}

#pragma mark - property
- (CGFloat)currentPlayProgress {
    return _currentPlayProgressView.progress;
}

- (void)setCurrentPlayProgress:(CGFloat)currentPlayProgress {
    if (currentPlayProgress <= 0) {
        [_currentPlayProgressView setProgress:currentPlayProgress];
    } else {
        [_currentPlayProgressView setProgress:currentPlayProgress animated:YES];
    }
}

- (CGFloat)currentBufferProgress {
    return _currentBufferProgressView.progress;
}

- (void)setCurrentBufferProgress:(CGFloat)currentBufferProgress {
    if (currentBufferProgress <= 0) {
        [_currentBufferProgressView setProgress:currentBufferProgress];
    } else {
        [_currentBufferProgressView setProgress:currentBufferProgress animated:YES];
    }
}

- (UIProgressView *)currentPlayProgressView {
    if (_currentPlayProgressView == nil) {
        _currentPlayProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.dog_Width, self.dog_Height)];
        _currentPlayProgressView.progressTintColor = [UIColor dog_ColorWithHex:0x00ffff];
        _currentPlayProgressView.trackTintColor = [UIColor clearColor];
    }
    return _currentPlayProgressView;
}

- (UIProgressView *)currentBufferProgressView {
    if (_currentBufferProgressView == nil) {
        _currentBufferProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.dog_Width, self.dog_Height)];
        _currentBufferProgressView.progressTintColor = [UIColor dog_ColorWithHex:0xefefef];
        _currentBufferProgressView.trackTintColor = [UIColor clearColor];
    }
    return _currentBufferProgressView;
}

@end
