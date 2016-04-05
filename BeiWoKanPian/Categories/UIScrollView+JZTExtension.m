//
//  UIScrollView+JZTExtension.m
//  家装通
//
//  Created by Bi Weiming on 15/9/1.
//  Copyright (c) 2015年 Nihility-Ming. All rights reserved.
//

#import "UIScrollView+JZTExtension.h"
#import <objc/runtime.h>
#import "UIColor+Extension.h"

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
#define StatusBar_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

CGRect UIScrollViewNotAdjustsSInsetsFrame() {
    CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat Y = statusBarHeight + NavigationBar_HEIGHT;
    return CGRectMake(0, Y, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - statusBarHeight);
}

CGRect UIScrollViewNotAdjustsSubtractTabBarInsetsFrame() {
    CGFloat statusBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat Y = statusBarHeight + NavigationBar_HEIGHT;
    return CGRectMake(0, Y, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBar_HEIGHT - statusBarHeight - 49.0f);
}

@interface UIScrollView()

@property (assign, nonatomic) BOOL jzt_emptyViewFlag;

@end

static const void *k_jzt_emptyViewFlagKey = &k_jzt_emptyViewFlagKey;
static const void *k_jzt_allowDisplayEmptyDataSetViewKey = &k_jzt_allowDisplayEmptyDataSetViewKey;

@implementation UIScrollView (JZTExtension)

- (void)setJzt_emptyViewFlag:(BOOL)jzt_emptyViewFlag {
    objc_setAssociatedObject(self, k_jzt_emptyViewFlagKey, @(jzt_emptyViewFlag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)jzt_emptyViewFlag {
    return [objc_getAssociatedObject(self, k_jzt_emptyViewFlagKey) boolValue];
}

- (void)setJzt_allowDisplayEmptyDataSetView:(BOOL)jzt_allowDisplayEmptyDataSetView {
    objc_setAssociatedObject(self, k_jzt_allowDisplayEmptyDataSetViewKey, @(jzt_allowDisplayEmptyDataSetView), OBJC_ASSOCIATION_RETAIN);
    
    if (jzt_allowDisplayEmptyDataSetView) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    } else {
        self.emptyDataSetSource = nil;
        self.emptyDataSetDelegate = nil;
    }
}

- (BOOL)jzt_allowDisplayEmptyDataSetView {
    return [objc_getAssociatedObject(self, k_jzt_allowDisplayEmptyDataSetViewKey) boolValue];
}

#pragma mark- DZNEmptyDataSet Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"没有数据";
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];
    UIColor *textColor = [UIColor jzt_colorWithHexString:@"7a7d83"];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"没有找到任何数据，请重新获取数据.";
    UIFont *font = [UIFont boldSystemFontOfSize:13.0];
    UIColor *textColor = [UIColor jzt_colorWithHexString:@"7a7d83"];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *imageName = @"empty_icon";
    return [UIImage imageNamed:imageName];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 5.0f;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointZero;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.jzt_emptyViewFlag) {
        return YES;
    } else {
        self.jzt_emptyViewFlag = YES;
        return NO;
    }
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"%s",__FUNCTION__);
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    NSLog(@"%s",__FUNCTION__);
}

@end
