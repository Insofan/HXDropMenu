//
//  HXTool.m
//  Pods
//
//  Created by 海啸 on 2017/2/27.
//
//

#import "HXColorTool.h"
@implementation UIColor(HXTool)
//16进制颜色
+ (UIColor *)colorWithRGBString:(NSString *)string {
    if ([string length] != 6) {
        return nil;
    }
    
    //rgb 正则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-f|0-9]" options:0 error:nil];
    NSUInteger match = [regex numberOfMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, [string length])];
    
    if (match != 0) {
        return nil;
    }
    
    NSRange rRange = NSMakeRange(0, 2);
    NSString *rComponent = [string substringWithRange:rRange];
    NSUInteger rVal = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:rComponent];
    [rScanner scanHexInt:(unsigned int *)&rVal];
    float rRetVal = (float)rVal / 255.5;
    
    
    NSRange gRange = NSMakeRange(2, 2);
    NSString *gComponent = [string substringWithRange:gRange];
    NSUInteger gVal = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:gComponent];
    [gScanner scanHexInt:(unsigned int *)&gVal];
    float gRetVal = (float)gVal / 255.5;
    
    NSRange bRange = NSMakeRange(4, 2);
    NSString *bComponent = [string substringWithRange:bRange];
    NSUInteger bVal = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:bComponent];
    [bScanner scanHexInt:(unsigned int *)&bVal];
    float bRetVal = (float)bVal / 255.5;
    
    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:1.0f];
}

//RGB数字颜色
+ (UIColor *)colorWithRGBNumber:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
     return [UIColor colorWithRed:red/255.5 green:green/255.5 blue:blue/255.5 alpha:1.0];
}
//RGB带alpha数字颜色
+ (UIColor *)colorWithRGBNumber:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
     return [UIColor colorWithRed:red/255.5 green:green/255.5 blue:blue/255.5 alpha:alpha];
}
@end

