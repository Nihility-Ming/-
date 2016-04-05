//
//  KPDataReader.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPDataReader.h"
#import <MagicalRecord/MagicalRecord.h>
#import "KPUserConfigEntity.h"

@implementation KPDataReader


- (instancetype)init
{
    if (self = [super init]) {
        _parentDirName = @"";
    }
    
    return self;
}

- (void)setParentDirName:(NSString *)parentDirName {
    if (parentDirName == nil) {
        return;
    }
    _parentDirName = parentDirName;
}

+ (void)checkCanRead:(void (^)(BOOL))callback
{
    if(callback) callback([[KPUserConfigEntity sharedInstance].enabled boolValue]);
}

- (void)loadData:(void (^)(NSArray<KPFileEntity *> *))callback
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentDirName == %@", _parentDirName];
    NSArray <KPFileEntity *> *entities = [KPFileEntity MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
    if (callback) {
        callback(entities);
    }
}

@end
