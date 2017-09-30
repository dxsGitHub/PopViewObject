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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"。。。" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick:)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"弹出" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)buttonClick:(UIButton *)sender {
    
    _popViewObj = [[PopViewObject alloc] initPopViewWithContainerView:self.view rectangleFrame:CGRectMake(self.view.frame.size.width - 185, 64, 180, 200) arrowLength:30.f arrowHeight:30.f contactLeftX:140.f arrowDirection:PopviewDirectionUp titleArray:@[@"飞飞", @"么么", @"哒哒", @"哈哈", @"嘿嘿", @"吼吼", @"嘻嘻", @"呵呵"] imagesArray:nil cornerRadius:YES];
    
    __weak PopViewObject *pop = _popViewObj;
    
    _popViewObj.selectItemBlock = ^(NSInteger row) {
        
        NSLog(@"row = %ld", row);
        
        [pop dismissPopviewToStartPosition:sender.center];
    };
}

- (IBAction)click:(UIButton *)sender {
    _popViewObj = [[PopViewObject alloc] initPopViewWithContainerView:self.view rectangleFrame:CGRectMake(self.view.center.x - 90, self.view.frame.size.height - 200 - 215, 180, 200) arrowLength:30.f arrowHeight:30.f contactLeftX:75.f arrowDirection:PopviewDirectionDown titleArray:@[@"飞飞", @"么么", @"哒哒", @"哈哈", @"嘿嘿", @"吼吼", @"嘻嘻", @"呵呵"] imagesArray:nil cornerRadius:YES];
    
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
