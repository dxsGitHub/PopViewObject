//
//  PopViewObject.h
//
//  Created by dxs on 2017/9/19.
//  Copyright © 2017年 dxs. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum{
    PopviewDirectionDown,
    PopviewDirectionUp
} PopViewDirection;

@interface PopViewObject : UIView

@property (nonatomic, strong) void(^selectItemBlock)(NSInteger row);


- (instancetype)initPopViewWithStartPoint:(CGPoint)point
                           rectangleWidth:(CGFloat)width
                          rectangleHeight:(CGFloat)height
                             popDirection:(PopViewDirection)direction
                               arrowWidth:(CGFloat)arrowWidth
                              arrowHeight:(CGFloat)arrowHeight
                               titleArray:(NSArray *)titles
                              imagesArray:(NSArray *)images
                             cornerRadius:(BOOL)radius;

- (void)dismissPopviewToStartPosition:(CGPoint)point;

@end

