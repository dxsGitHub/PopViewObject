//
//  PopViewObject.m
//  runtime--oc1
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

- (instancetype)initPopViewWithContainerView:(UIView *)container rectangleFrame:(CGRect)frame arrowLength:(CGFloat)length arrowHeight:(CGFloat)height contactLeftX:(CGFloat)leftX arrowDirection:(PopViewDirection)direction titleArray:(NSArray *)titles imagesArray:(NSArray *)images cornerRadius:(BOOL)radius {
    
    if (self = [super init]) {
        
        [self initDataWithTitlesArray:titles imagesArray:images isCornerRadius:YES];
        
        [self popViewWithContainerView:container rectangleFrame:frame arrowLength:length arrowHeight:height contactLeftX:leftX arrowDirection:direction];
        [self setMaskViewWithContainer:container];
        
        [UIView animateWithDuration:.3f animations:^{
            self.alpha = 1.f;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    return self;
}

- (void)setMaskViewWithContainer:(UIView *)container {
    self.frame = container.bounds;
    self.alpha = 0.01f;
    [container addSubview:self];
}

- (void)initDataWithTitlesArray:(NSArray *)titles imagesArray:(NSArray *)images isCornerRadius:(BOOL)radius {
    _titlesArray = [NSArray arrayWithArray:titles];
    _imagesNameArray = [NSArray arrayWithArray:images];
    _isCornerRadius = radius;
}

- (void)setPopviewBackgroundColorWithPopview:(UIView *)popview color:(UIColor *)color {
    UIView *bgColorView = [[UIView alloc] initWithFrame:popview.bounds];
    bgColorView.backgroundColor = color;
    [popview addSubview:bgColorView];
}



- (void)popViewWithContainerView:(UIView *)container rectangleFrame:(CGRect)frame arrowLength:(CGFloat)length arrowHeight:(CGFloat)height contactLeftX:(CGFloat)leftX arrowDirection:(NSInteger)direction {
    
    CGFloat cornerRadius = _isCornerRadius ? 5 : 0;
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame) + height);
    
    UIView *insideView = [[UIView alloc] initWithFrame:frame];
    insideView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f  blue:230/255.f  alpha:1.f];
    [self addSubview:insideView];
    
    CGFloat insideViewWidth = CGRectGetWidth(insideView.frame);
    CGFloat insideViewHeight = CGRectGetHeight(insideView.frame);
    
    CGPoint point1 = CGPointMake(0, direction < 1 ? height : 0);
    CGPoint point2 = CGPointMake(direction < 1 ? leftX : insideViewWidth, direction < 1 ? height : 0);
    CGPoint point3 = CGPointMake(direction < 1 ? leftX + length / 2.f : insideViewWidth, direction < 1 ? 0 : insideViewHeight - height);
    CGPoint point4 = CGPointMake(leftX + length, direction < 1 ? height : insideViewHeight - height);
    CGPoint point5 = CGPointMake(direction < 1 ? insideViewWidth : leftX + length / 2.f, direction < 1 ? height : insideViewHeight);
    CGPoint point6 = CGPointMake(direction < 1 ? insideViewWidth : leftX, direction < 1 ? insideViewHeight : insideViewHeight - height);
    CGPoint point7 = CGPointMake(0, direction < 1 ? insideViewHeight : insideViewHeight - height);
    
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
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, insideViewHeight-cornerRadius-height) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
        [path addLineToPoint:point4];
        [path addLineToPoint:point5];
        [path addLineToPoint:point6];
        
        [path addArcWithCenter:CGPointMake(cornerRadius, insideViewHeight-cornerRadius-height) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    } else {
        
        [path addArcWithCenter:CGPointMake(cornerRadius, height+cornerRadius) radius:cornerRadius startAngle:2*M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path addLineToPoint:point4];
        
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, height + cornerRadius) radius:cornerRadius startAngle:3*M_PI_2 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(insideViewWidth-cornerRadius, insideViewHeight-cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(cornerRadius, insideViewHeight-cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    insideView.layer.mask = layer;
    
    CGRect subContainerFrame = direction < 1 ? CGRectMake(0, height, CGRectGetWidth(frame), CGRectGetHeight(frame) - height) : CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - height);
    [self addSelectCellItemToContainerView:insideView frame:subContainerFrame];
}

- (void)addSelectCellItemToContainerView:(UIView *)container frame:(CGRect)frame {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f  blue:230/255.f  alpha:1.f];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
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
    
    if (_imagesNameArray.count > 0) {
      cell.imageView.image = [UIImage imageNamed:_imagesNameArray[indexPath.row]];
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
