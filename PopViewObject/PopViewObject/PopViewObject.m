//
//  PopViewObject.m
//
//  Created by dxs on 2017/9/19.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import "PopViewObject.h"

@interface PopViewObject ()<UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imagesNameArray;
@property (nonatomic, assign) BOOL isCornerRadius;

@end

@implementation PopViewObject

- (instancetype)initPopViewWithStartPoint:(CGPoint)point rectangleWidth:(CGFloat)width rectangleHeight:(CGFloat)height popDirection:(PopViewDirection)direction arrowWidth:(CGFloat)arrowWidth arrowHeight:(CGFloat)arrowHeight titleArray:(NSArray *)titles imagesArray:(NSArray *)images cornerRadius:(BOOL)radius{
    
    if (self = [super init]) {
        [self popViewWithPopupPoint:point rectangleWidth:width rectangleHeight:height popDirection:direction arrowWidth:arrowWidth arrowHeight:arrowHeight];
        [self initDataWithTitlesArray:titles imagesArray:images isCornerRadius:radius];
        self.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.alpha = 0.001f;
    }
    
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
    
    return self;
}

- (void)popViewWithPopupPoint:(CGPoint)point rectangleWidth:(CGFloat)width rectangleHeight:(CGFloat)height popDirection:(PopViewDirection)direction arrowWidth:(CGFloat)arrowWidth arrowHeight:(CGFloat)arrowHeight {
    
    CGFloat cornerRadius = 5;
    NSLog(@"cornerRadius = %f", cornerRadius);
    
    if (point.x < 0 || point.y < 0 || width < 0 || height < 0 || arrowWidth < 0 || arrowHeight < 0) {
        NSLog(@"popup parameters is wrong, every parameter must greater than 0");
        return;
    }
    
    if (width > [UIScreen mainScreen].bounds.size.width) {
        NSLog(@"popup rectangle'width must less than screen'width");
        return;
    }
    
    if (width > [UIScreen mainScreen].bounds.size.height) {
        NSLog(@"popup rectangle'height must less than screen'height");
        return;
    }
    
    if (arrowWidth > width) {
        NSLog(@"arrowWidth  must less than rectangleWidth");
        return;
    }
    
    if (arrowHeight > [UIScreen mainScreen].bounds.size.height) {
        NSLog(@"arrowHeight  must less than screen'height");
        return;
    }
    
    if (arrowHeight + height > [UIScreen mainScreen].bounds.size.height) {
        NSLog(@"arrowHeight add height also must less than screen'height");
        return;
    }
    
    
    CGFloat minX = 0;
    CGFloat maxX = 0;
    CGFloat diffX = 0;
    
    if (!(point.x - width / 2 > 0)) {
        minX = 0;
        maxX = minX + width;
        diffX = point.x - width / 2;
    } else if ((point.x - width / 2 > 0) && (point.x + width / 2 < [UIScreen mainScreen].bounds.size.width)) {
        minX = point.x - width / 2;
        maxX = minX + width;
    } else {
        maxX = [UIScreen mainScreen].bounds.size.width;
        minX = maxX - width;
        diffX = width / 2 - (maxX - point.x);
    }
    
    
    CGFloat minY = 0;
    CGFloat maxY = 0;
    
    if (direction == PopviewDirectionUp) {
        if (point.y - arrowHeight - height < 0) {
            minY = 0;
            maxY = point.y;
        } else {
            minY = point.y - arrowHeight - height;
            maxY = point.y;
        }
    } else {
        if (point.y + arrowHeight + height > [UIScreen mainScreen].bounds.size.height) {
            minY = point.y;
            maxY = [UIScreen mainScreen].bounds.size.height;
        } else {
            minY = point.y;
            maxY = minY + arrowHeight + height;
        }
    }
    
    CGRect frame = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    
    UIView *insideView = [[UIView alloc] initWithFrame:frame];
    insideView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f  blue:230/255.f  alpha:1.f];
    //    insideView.backgroundColor = [UIColor greenColor];
    [self addSubview:insideView];
    
    
    CGFloat insideViewWidth = CGRectGetWidth(insideView.frame);
    CGFloat insideViewHeight = CGRectGetHeight(insideView.frame);
    
    CGPoint point1 = CGPointMake(0, direction < 1 ? arrowHeight : 0);
    CGPoint point2 = CGPointMake(direction < 1 ? (insideViewWidth - arrowWidth) / 2 : insideViewWidth, direction < 1 ? arrowHeight : 0);
    CGPoint point3 = CGPointMake(direction < 1 ? insideViewWidth / 2 + diffX : insideViewWidth, direction < 1 ? 0 : insideViewHeight - arrowHeight);
    CGPoint point4 = CGPointMake((insideViewWidth + arrowWidth) / 2, direction < 1 ? arrowHeight : insideViewHeight - arrowHeight);
    CGPoint point5 = CGPointMake(direction < 1 ? insideViewWidth : insideViewWidth / 2 + diffX, direction < 1 ? arrowHeight : insideViewHeight);
    CGPoint point6 = CGPointMake(direction < 1 ? insideViewWidth : insideViewWidth / 2 - arrowWidth / 2, direction < 1 ? insideViewHeight : insideViewHeight - arrowHeight);
    CGPoint point7 = CGPointMake(0, direction < 1 ? insideViewHeight : insideViewHeight - arrowHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (cornerRadius == 0) {
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path addLineToPoint:point4];
        [path addLineToPoint:point5];
        [path addLineToPoint:point6];
        [path addLineToPoint:point7];
    }else if (direction > 0){
        //顺序有影响
        [path addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius startAngle:2*M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, cornerRadius) radius:cornerRadius startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, insideViewHeight-cornerRadius-arrowHeight) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
        [path addLineToPoint:point4];
        [path addLineToPoint:point5];
        [path addLineToPoint:point6];
        
        [path addArcWithCenter:CGPointMake(cornerRadius, insideViewHeight - cornerRadius - arrowHeight) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    } else {
        
        [path addArcWithCenter:CGPointMake(cornerRadius, arrowHeight + cornerRadius) radius:cornerRadius startAngle:2*M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path addLineToPoint:point4];
        
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, arrowHeight + cornerRadius) radius:cornerRadius startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, insideViewHeight-cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(cornerRadius, insideViewHeight-cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    insideView.layer.mask = layer;
    
    CGRect subContainerFrame = direction < 1 ? CGRectMake(0, arrowHeight, CGRectGetWidth(frame), CGRectGetHeight(frame) - arrowHeight) : CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - arrowHeight);
    [self addSelectCellItemToContainerView:insideView frame:subContainerFrame];
    
}

- (void)initDataWithTitlesArray:(NSArray *)titles imagesArray:(NSArray *)images isCornerRadius:(BOOL)radius {
    _titlesArray = [NSArray arrayWithArray:titles];
    _imagesNameArray = [NSArray arrayWithArray:images];
    _isCornerRadius = radius;
}


- (void)addSelectCellItemToContainerView:(UIView *)container frame:(CGRect)frame {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f  blue:230/255.f  alpha:1.f];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    tableView.separatorColor = [UIColor grayColor];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.bounces = NO;
    [container addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //定制符合自己要求的Cell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f  blue:230/255.f  alpha:1.f];
    
    if (_imagesNameArray.count > 0 && indexPath.row < _imagesNameArray.count) {
        cell.imageView.image = [UIImage imageNamed:_imagesNameArray[indexPath.row]];
    }
    
    if (indexPath.row != 0) {
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(cell.frame), CGRectGetMinY(cell.frame), CGRectGetWidth(cell.frame), 0.5)];
        [separatorLine setBackgroundColor:[UIColor darkGrayColor]];
        [cell addSubview: separatorLine];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.text = _titlesArray ? _titlesArray[indexPath.row] : @"标题为空";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectItemBlock) {
        self.selectItemBlock(indexPath.row);
    }
}

- (void)dismissPopviewToStartPosition:(CGPoint)point {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.center];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = 0.2f;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    CABasicAnimation *animScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animScale.toValue = [NSNumber numberWithFloat:0.01f];
    animScale.duration = 0.2f;
    animScale.repeatCount = 1;
    animScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.2f;
    group.animations = @[animation, animScale];
    group.autoreverses = NO;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode=kCAFillModeForwards;
    [self.layer addAnimation:group forKey:@"group"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeFromSuperview];
}

@end

