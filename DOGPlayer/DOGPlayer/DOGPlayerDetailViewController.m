//
//  DOGPlayerDetailViewController.m
//  DOGPlayer
//
//  Created by RavenZ on 2018/6/9.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerDetailViewController.h"

#import "DOGPlayerWidget.h"
#import "DOGPlayerItem.h"

#import "UIView+DOG.h"

@interface DOGPlayerDetailViewController ()

@property (nonatomic, strong) DOGPlayerWidget *playerWidget;

@end

@implementation DOGPlayerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playerWidget];
    
    NSString *url = @"";
    DOGPlayerItem *item = [[DOGPlayerItem alloc] initWithDictionary:@{kVideoURL : url }];
    [self.playerWidget startPlay:item];
}

#pragma mark - property
- (DOGPlayerWidget *)playerWidget {
    if (_playerWidget == nil) {
        _playerWidget = [[DOGPlayerWidget alloc] initWithFrame:CGRectMake(0, 0, self.view.dog_Width, self.view.dog_Width * 3/4)];
        _playerWidget.center = self.view.center;
    }
    return _playerWidget;
}

@end
