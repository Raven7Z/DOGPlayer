//
//  DOGPlayerTabBarController.m
//  DOGPlayer
//
//  Created by butterfly on 27/2/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerTabBarController.h"

#import "DOGPlayerMainViewController.h"
#import "ViewController.h"

#import "DOGPlayerConfigInstance.h"

@interface DOGPlayerTabBarController ()

@end

@implementation DOGPlayerTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    ViewController *main = [[ViewController alloc] init];
    main.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:nil tag:0];
    
    DOGPlayerMainViewController *second = [[DOGPlayerMainViewController alloc] init];
    second.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:0];
    
    self.viewControllers = @[main, second];
    
    [DOGPlayerConfigInstance shareInstance].rootController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
