//
//  KPCoreDataManager.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPCoreDataManager.h"
#import <MagicalRecord/MagicalRecord.h>

static NSString * const kStoreNamed = @"BeiWoKanPian.sqlite";

@implementation KPCoreDataManager

+ (void)setup
{
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kStoreNamed];
}

+ (void)cleanUp
{
    [MagicalRecord cleanUp];
}

@end
