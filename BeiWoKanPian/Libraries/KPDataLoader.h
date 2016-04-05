//
//  KPDataLoader.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPVideoEntity.h"
#import "KPDirEntity.h"

@interface KPDataLoader : NSObject

@property (copy, nonatomic) void(^userIsNotSetCallback)(void);

@property (copy, nonatomic) void(^loadDataCallback)(NSArray <KPFileEntity *> *entities);

@property (copy, nonatomic) void(^currentLoadFileCallback)(NSString *filePath);


- (void)setup;

@end
