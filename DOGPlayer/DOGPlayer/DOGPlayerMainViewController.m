//
//  DOGPlayerMainViewController.m
//  DOGPlayer
//
//  Created by butterfly on 27/2/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerMainViewController.h"

#import "DOGPlayerDetailViewController.h"

@interface DOGPlayerMainViewController ()

@property (nonatomic, strong) UIButton *pushVideoButton;

@end

@implementation DOGPlayerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pushVideoButton];
}

#pragma mark - action
- (void)pushVideoButtonClicked:(UIButton *)sender {
    DOGPlayerDetailViewController *viewController = [[DOGPlayerDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - property
- (UIButton *)pushVideoButton {
    if (_pushVideoButton == nil) {
        _pushVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pushVideoButton.backgroundColor = [UIColor greenColor];
        _pushVideoButton.frame = CGRectMake(100, 100, 100, 40);
        [_pushVideoButton setTitle:@"视频" forState:UIControlStateNormal];
        [_pushVideoButton addTarget:self action:@selector(pushVideoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushVideoButton;
}

@end
