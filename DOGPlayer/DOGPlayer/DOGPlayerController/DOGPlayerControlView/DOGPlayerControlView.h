//
//  DOGPlayerControlView.h
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DOGPlayerDunkerView.h"
#import "DOGPlayerControlViewProtocol.h"

@interface DOGPlayerControlView : UIView

@property (nonatomic, readonly) DOGPlayerDunkerView *dunkerView;
@property (nonatomic, weak) id <DOGPlayerSliderViewDelegate> delegate;
@property (nonatomic, weak) id <DOGPlayerControlViewProtocol> controlViewDelegate;

@end
