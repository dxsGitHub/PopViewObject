//
//  PopViewObject.h
//  runtime--oc1
//
//  Created by dxs on 2017/9/19.
//  Copyright © 2017年 dxs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PopviewDirectionUp,
    PopviewDirectionDown
} PopViewDirection;

@interface PopViewObject : UIControl

@property (nonatomic, strong) void(^selectItemBlock)(NSInteger row);

- (instancetype)initPopViewWithContainerView:(UIView *)container
                        rectangleFrame:(CGRect)frame
                           arrowLength:(CGFloat)length
                           arrowHeight:(CGFloat)height
                          contactLeftX:(CGFloat)leftX
                        arrowDirection:(PopViewDirection)direction
                            titleArray:(NSArray*)titles
                           imagesArray:(NSArray *)images
                          cornerRadius:(BOOL)radius;

- (void)dismissPopviewToStartPosition:(CGPoint)point;

@end
