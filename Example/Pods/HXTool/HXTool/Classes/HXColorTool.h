//
//  HXTool.h
//  Pods
//
//  Created by 海啸 on 2017/2/27.
//
//
#import <UIKit/UIKit.h>
@interface UIColor(HXTool)
+ (UIColor *)colorWithRGBString:(NSString *)string;
+ (UIColor *)colorWithRGBNumber:(NSUInteger )red green:(NSUInteger )green blue:(NSUInteger )blue;
+ (UIColor *)colorWithRGBNumber:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;
@end
