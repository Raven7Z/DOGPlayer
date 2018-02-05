//
//  DOGPlayerWidget.h
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DOGPlayerItem.h"

@interface DOGPlayerWidget : UIView

/**
 start play

 @param item data
 */
- (void)startPlay:(DOGPlayerItem *)item;

@end
