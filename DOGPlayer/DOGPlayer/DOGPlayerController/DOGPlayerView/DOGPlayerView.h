//
//  DOGPlayerView.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DOGPlayerProtocol.h"
#import "DOGPlayerViewProtocol.h"

@interface DOGPlayerView : UIView
<
DOGPlayerProtocol
,DOGPlayerViewProtocol
>

@property (nonatomic, weak) id <DOGPlayerViewDelegate> delegate;

/**
 current player status
 */
@property (nonatomic, readonly) DOGPlayerViewStatus status;

@end
