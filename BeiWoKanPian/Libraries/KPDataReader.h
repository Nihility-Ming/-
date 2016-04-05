//
//  KPDataReader.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPVideoEntity.h"
#import "KPDirEntity.h"

@interface KPDataReader : NSObject

@property (strong, nonatomic) NSString *parentDirName;

+ (void)checkCanRead:(void(^)(BOOL can))callback;

- (void)loadData:(void (^)(NSArray<KPFileEntity *> *))callback;

@end
