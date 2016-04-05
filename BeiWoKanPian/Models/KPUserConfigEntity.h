//
//  KPUserConfigEntity.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

typedef NS_ENUM(NSInteger, KPFTPProtocolType) {
    KPFTPProtocolTypeNormal = 0,
    KPFTPProtocolTypeAnonymous
};

typedef NS_ENUM(NSInteger, KPHTTPProtocolType)
{
    KPHTTPProtocolTypeHTTP = 0,
    KPHTTPProtocolTypeHTTPS
};


NS_ASSUME_NONNULL_BEGIN

@interface KPUserConfigEntity : NSManagedObject

+ (instancetype)sharedInstance;

- (void)save;

- (KPFTPProtocolType)FTPProtocolType;

- (KPHTTPProtocolType)HTTPProtocolType;


@end

NS_ASSUME_NONNULL_END

#import "KPUserConfigEntity+CoreDataProperties.h"
