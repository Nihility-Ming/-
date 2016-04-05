//
//  KPUserConfigEntity+CoreDataProperties.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KPUserConfigEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface KPUserConfigEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *path;

@property (nullable, nonatomic, retain) NSNumber *http_protocol;
@property (nullable, nonatomic, retain) NSNumber *http_port;

@property (nullable, nonatomic, retain) NSNumber *ftp_protocol;
@property (nullable, nonatomic, retain) NSNumber *ftp_port;
@property (nullable, nonatomic, retain) NSString *ftp_username;
@property (nullable, nonatomic, retain) NSString *ftp_password;

@property (nullable, nonatomic, retain) NSNumber *is_always_load;
@property (nullable, nonatomic, retain) NSDate *last_update_date;

@property (nullable, nonatomic, retain) NSNumber *enabled;
@property (nullable, nonatomic, retain) NSNumber *is_open_touchid;


@end

NS_ASSUME_NONNULL_END
