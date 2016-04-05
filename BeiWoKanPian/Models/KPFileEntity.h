//
//  KPFileEntity.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KPDirEntity;

NS_ASSUME_NONNULL_BEGIN

@interface KPFileEntity : NSManagedObject

- (NSString *)absoluteURLStr;

@end

NS_ASSUME_NONNULL_END

#import "KPFileEntity+CoreDataProperties.h"
