//
//  KPVideoEntity+CoreDataProperties.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KPVideoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface KPVideoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *format;
@property (nullable, nonatomic, retain) NSData *thumbnail;

@end

NS_ASSUME_NONNULL_END
