//
//  DOGPlayerTabBarController.m
//  DOGPlayer
//
//  Created by butterfly on 27/2/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerTabBarController.h"

#import "DOGPlayerMainViewController.h"
#import "DOGPlayerOtherViewController.h"

#import "DOGPlayerConfigInstance.h"

@interface DOGPlayerTabBarController ()

@end

@implementation DOGPlayerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    DOGPlayerMainViewController *main = [[DOGPlayerMainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    mainNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:nil tag:0];
    
    
    DOGPlayerOtherViewController *other = [[DOGPlayerOtherViewController alloc] init];
    UINavigationController *otherNav = [[UINavigationController alloc] initWithRootViewController:other];
    otherNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Other" image:nil tag:0];
    
    self.viewControllers = @[mainNav, otherNav];
    
    [DOGPlayerConfigInstance shareInstance].rootController = self;
}

@end
