//
//  ViewController.m
//  PopViewObject
//
//  Created by dxs on 2017/9/27.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "PopViewObject.h"



@interface ViewController ()

@property (strong, nonatomic) PopViewObject *popViewObj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"标题么么哒";
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"弹出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)buttonClick:(UIButton *)sender {
    
    _popViewObj = [[PopViewObject alloc] initPopViewWithStartPoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 50, 40) rectangleWidth:100 rectangleHeight:200 popDirection:PopviewDirectionDown arrowWidth:20 arrowHeight:20 titleArray:@[@"AAAA", @"BBBB", @"CCCC", @"DDDD", @"EEEE", @"FFFF"] imagesArray:@[@"A1", @"A2", @"A3",@"A4", @"A5", @"A6"] cornerRadius:YES];
    
    __weak PopViewObject *pop = _popViewObj;
    _popViewObj.selectItemBlock = ^(NSInteger row) {
        NSLog(@"row = %ld", row);
        [pop dismissPopviewToStartPosition:CGPointMake([UIScreen mainScreen].bounds.size.width - 50, 40)];
    };
    
}

- (IBAction)click:(UIButton *)sender {
    
    _popViewObj = [[PopViewObject alloc] initPopViewWithStartPoint:sender.center rectangleWidth:100 rectangleHeight:200 popDirection:PopviewDirectionUp arrowWidth:20 arrowHeight:20 titleArray:@[@"AAAA", @"BBBB", @"CCCC", @"DDDD", @"EEEE", @"FFFF"] imagesArray:@[@"A1", @"A2", @"A3",@"A4", @"A5", @"A6"] cornerRadius:YES];
    
    __weak PopViewObject *pop = _popViewObj;
    _popViewObj.selectItemBlock = ^(NSInteger row) {
        NSLog(@"row = %ld", row);
        [pop dismissPopviewToStartPosition:sender.center];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

