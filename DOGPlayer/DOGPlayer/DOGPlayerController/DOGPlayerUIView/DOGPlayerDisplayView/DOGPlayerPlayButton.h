//
//  DOGPlayerPlayButton.h
//  DOGPlayer
//
//  Created by butterfly on 24/2/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOGPlayerPlayButton : UIButton

/**
 creates and returns a dogPlayerPlayButton of a specified UIButtonType

 @param buttonType UIButtonType
 @return DOGPlayerPlayButton item
 */
+ (DOGPlayerPlayButton *)dogPlayerPlayButtonWithType:(UIButtonType)buttonType;

@end
