//
//  HXDropMenu.h
//  Pods
//
//  Created by 海啸 on 2017/3/22.
//
//

#import <UIKit/UIKit.h>

@interface HXDropMenu : UIView
//The table width, default is window width
@property (assign, nonatomic) CGFloat width;

//Cell Color default whiteColor
//下拉菜单cell的背景颜色默认是 E53935
@property (strong, nonatomic) UIColor *cellColor;

//Cell seprator color default whiteColor
//分割线颜色 默认是白色
@property (nonatomic, strong) UIColor *cellSeparatorColor;

//Cell accessory check mark color default whiteColor
//下拉菜单对好的颜色默认是白色
@property (nonatomic, strong) UIColor *cellAccessoryCheckmarkColor;

//Cell height
//下拉菜单行高
@property (assign, nonatomic) CGFloat cellHeight;

//Animation duration default is 0.4
//动画时长
@property (assign, nonatomic) CGFloat animationDuration;

//Text Color
//文本颜色
@property (strong, nonatomic) UIColor *textColor;

//Text Font
//文本字体大小
@property (strong, nonatomic) UIFont  *textFont;

//Background alpha 0.3
//背景Opacity值 默认0.3
@property (assign, nonatomic) CGFloat backgroundAlpha;

//Callback block
//回调闭包
@property (nonatomic, copy) void (^selectedAtIndex)(int index);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
@end
