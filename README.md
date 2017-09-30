# PopViewObject
第一版，用法很简单。只需要把PopViewObject一个实例设置成变量，然后把Click方法里的代码拷贝到你所要的位置。然后传入相应的参数即可。

下一个版本会根据点击点弹出view

- (void)buttonClick:(UIButton *)sender {

    _popViewObj = [[PopViewObject alloc] initPopViewWithContainerView:self.view rectangleFrame:CGRectMake(self.view.frame.size.width - 185, 64, 180, 200) arrowLength:30.f arrowHeight:30.f contactLeftX:140.f arrowDirection:PopviewDirectionUp titleArray:@[@"飞飞", @"么么", @"哒哒", @"哈哈", @"嘿嘿", @"吼吼", @"嘻嘻", @"呵呵"] imagesArray:nil cornerRadius:YES];

    __weak PopViewObject *pop = _popViewObj;
    
    _popViewObj.selectItemBlock = ^(NSInteger row) {

        NSLog(@"row = %ld", row);
        [pop dismissPopviewToStartPosition:sender.center];
    };
}
