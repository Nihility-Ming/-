//
//  KPFileTypeManager.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPFileTypeManager.h"

@implementation KPFileTypeManager

+ (NSArray<NSString *> *)acceptableVideoFormats
{
    return @[
             @"caff",
             @"aiff",
             @"ogg",
             @"wav",
             @"wmv",
             @"vob",
             @"flv",
             @"mpg",
             @"mpeg",
             @"mkv",
             @"avi",
             @"mov",
             @"mp4",
             @"3gp",
             @"m4v",
             @"vob"
             ];
}

@end
