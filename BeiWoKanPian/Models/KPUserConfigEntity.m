//
//  KPUserConfigEntity.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPUserConfigEntity.h"

@implementation KPUserConfigEntity

+ (instancetype)sharedInstance
{
    static KPUserConfigEntity *_entity;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _entity = [KPUserConfigEntity MR_findFirst];
        if (_entity == nil) {
            _entity = [KPUserConfigEntity MR_createEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    });
    
    return _entity;
}

- (void)save
{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (KPFTPProtocolType)FTPProtocolType
{
    return [self.ftp_protocol integerValue];
}

- (KPHTTPProtocolType)HTTPProtocolType
{
    return [self.http_protocol integerValue];
}

@end
