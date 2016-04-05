//
//  KPDirEntity+CoreDataProperties.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KPDirEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface KPDirEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<KPFileEntity *> *subFiles;

@end

@interface KPDirEntity (CoreDataGeneratedAccessors)

- (void)addSubFilesObject:(KPFileEntity *)value;
- (void)removeSubFilesObject:(KPFileEntity *)value;
- (void)addSubFiles:(NSSet<KPFileEntity *> *)values;
- (void)removeSubFiles:(NSSet<KPFileEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
