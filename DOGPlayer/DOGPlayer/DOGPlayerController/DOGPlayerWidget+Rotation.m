//
//  DOGPlayerWidget+Rotation.m
//  DOGPlayer
//
//  Created by butterfly on 6/3/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerWidget+Rotation.h"

#import "DOGPlayerConfigInstance.h"

@implementation DOGPlayerWidget (Rotation)

- (void)tabBarHidden:(BOOL)hidden {
    [DOGPlayerConfigInstance shareInstance].rootController.tabBar.hidden = hidden;
}

@end
