//
//  HXButtonTool.m
//  HXTool
//
//  Created by 海啸 on 2017/2/28.
//  Copyright © 2017年 Insofan. All rights reserved.
//

#import "HXButtonTool.h"

@implementation UIButton(HXTool)
+ (instancetype)buttonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    UIButton *button = [self new];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
//    [button sizeToFit];
    return button;
}
@end
