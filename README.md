# PopViewObject

1初始化：第二版精简了初始化方法，方便使用。所需参数【界面参数：弹出点， 弹出视图的宽和高，尖角的宽和高； 内容数据：标题数组和icon数组，其中icon数组可为空，参数cornerRadius为Bool值，YES和NO效果一样，内部没做处理，打算用来做是否圆角的】

2，调用如下 ：- (IBAction)click:(UIButton *)sender {

    _popViewObj = [[PopViewObject alloc] initPopViewWithStartPoint:sender.center rectangleWidth:100 rectangleHeight:200 popDirection:PopviewDirectionUp arrowWidth:20 arrowHeight:20 titleArray:@[@"AAAA", @"BBBB", @"CCCC", @"DDDD",   @"EEEE", @"FFFF"] imagesArray:@[@"A1", @"A2", @"A3",@"A4", @"A5", @"A6"] cornerRadius:YES];

    __weak PopViewObject *pop = _popViewObj;
    
    _popViewObj.selectItemBlock = ^(NSInteger row)  {
    NSLog(@"row = %ld", row);
    [pop dismissPopviewToStartPosition:sender.center];
    };
}
