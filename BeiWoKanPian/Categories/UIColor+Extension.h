//
//  UIColor+Extension.h
//  家装通
//
//  Created by Bi Weiming on 15/8/7.
//  Copyright (c) 2015年 智慧城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)jzt_colorWithHexString: (NSString *)color;
+ (UIColor *)jzt_colorWithHexString: (NSString *)color alpha:(float)alpha;

@end
