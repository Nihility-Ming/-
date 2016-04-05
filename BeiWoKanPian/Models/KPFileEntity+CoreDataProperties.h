//
//  KPFileEntity+CoreDataProperties.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KPFileEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface KPFileEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *parentDirName;
@property (nullable, nonatomic, retain) NSString *owner;
@property (nullable, nonatomic, retain) NSNumber *size;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSNumber *isDir;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *modDate;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) KPDirEntity *parentDir;

@end

NS_ASSUME_NONNULL_END
