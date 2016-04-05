//
//  KPFileEntity+CoreDataProperties.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KPFileEntity+CoreDataProperties.h"

@implementation KPFileEntity (CoreDataProperties)

@dynamic owner;
@dynamic size;
@dynamic type;
@dynamic name;
@dynamic modDate;
@dynamic path;
@dynamic parentDir;
@dynamic parentDirName;
@dynamic isDir;

@end
