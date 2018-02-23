//
//  DOGPlayerLoadingView.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/2/13.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOGPlayerLoadingView : UIView

/**
 create loadingView

 @param frame loadingView frame
 @param duration loading duration
 @return DOGPlayerLoadingView model
 */
- (instancetype)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration;

- (void)startLoading;

- (void)endLoading;

@end
