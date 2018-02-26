//
//  DOGPlayerPlayButton.m
//  DOGPlayer
//
//  Created by butterfly on 24/2/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerPlayButton.h"

@implementation DOGPlayerPlayButton

+ (DOGPlayerPlayButton *)dogPlayerPlayButtonWithType:(UIButtonType)buttonType {
    
    DOGPlayerPlayButton *button = [super buttonWithType:buttonType];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"dog_stop"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"dog_play"] forState:UIControlStateSelected];

    return button;
}

@end
