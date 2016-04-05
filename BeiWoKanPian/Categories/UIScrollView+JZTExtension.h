//
//  UIScrollView+JZTExtension.h
//  家装通
//
//  Created by Bi Weiming on 15/9/1.
//  Copyright (c) 2015年 Nihility-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIScrollView+EmptyDataSet.h>

@interface UIScrollView (JZTExtension) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/**
 *  Allow Display Empty Data Set View
 *  Default is NO
 */
@property (assign, nonatomic) BOOL jzt_allowDisplayEmptyDataSetView UI_APPEARANCE_SELECTOR;

@end
