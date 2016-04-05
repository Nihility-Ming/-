//
//  KPDataLoader.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPDataLoader.h"
#import <MagicalRecord/MagicalRecord.h>
#import <FTPManager/FTPManager.h>
#import "KPUserConfigEntity.h"
#import "KPFileTypeManager.h"

@interface KPDataLoader()
{
    FTPManager *_FTPManager;
}

@property (strong, nonatomic) KPUserConfigEntity *configEntity;

@end

@implementation KPDataLoader

- (instancetype)init
{
    if (self = [super init]) {
        _configEntity = [KPUserConfigEntity sharedInstance];
        _FTPManager = [[FTPManager alloc] init];
    }
    
    return self;
}

- (FMServer *)p_getFMServerWithPath:(NSString *)path
{
    
    FMServer *server;
    
    if(_configEntity.FTPProtocolType == KPFTPProtocolTypeNormal) {
        NSString *url = [_configEntity.url stringByAppendingPathComponent:_configEntity.path];
        NSString *thePath = [url stringByAppendingPathComponent:path];
        server = [FMServer serverWithDestination:thePath username:_configEntity.ftp_username password:_configEntity.ftp_password];
    } else if (_configEntity.FTPProtocolType == KPFTPProtocolTypeAnonymous){
        server = [FMServer anonymousServerWithDestination:_configEntity.url];
    }
    
    if ([_configEntity.ftp_port intValue] != 0) {
        server.port = [_configEntity.ftp_port intValue];
    }
    
    return server;
}

/*
 
 kCFFTPResourceGroup = staff;
 kCFFTPResourceLink = "";
 kCFFTPResourceModDate = "2014-07-14 16:00:00 +0000";
 kCFFTPResourceMode = 420;
 kCFFTPResourceName = "PHP\U5927\U578b\U7f51\U7ad9\U6838\U5fc3\U6280\U672f\U4e4b-mysql\U4f18\U53168(\U8bfb\U5199\U5206\U79bb\U6280\U672f\U4ecb\U7ecd).wmv";
 kCFFTPResourceOwner = Nihility;
 kCFFTPResourceSize = 24020373;
 kCFFTPResourceType = 8;
 */

/*
 #define	DT_UNKNOWN	 0
 #define	DT_FIFO		 1
 #define	DT_CHR		 2
 #define	DT_DIR		 4
 #define	DT_BLK		 6
 #define	DT_REG		 8
 #define	DT_LNK		10
 #define	DT_SOCK		12
 #define	DT_WHT		14
 */

- (NSArray <KPFileEntity *> *)parserWithPath:(NSString *)path parentDirEntity:(KPDirEntity *)parentDirEntity
{
    
    if (!path) path = @"";
    FMServer *server = [self p_getFMServerWithPath:path];
    NSArray <NSDictionary *> *files = [_FTPManager contentsOfServer:server];
    
    if (path.length > 0 && self.currentLoadFileCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentLoadFileCallback(path);
        });
    }
    
    NSMutableArray *returnFiles = [NSMutableArray array];
    
    [files enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
        // 索要
        NSDate *modDate = dict[(__bridge NSString *)kCFFTPResourceModDate];
        NSString *name = dict[(__bridge NSString *)kCFFTPResourceName];
        NSString *owner = dict[(__bridge NSString *)kCFFTPResourceOwner];
        NSNumber *size = dict[(__bridge NSNumber *)kCFFTPResourceSize];
        NSNumber *type = dict[(__bridge NSNumber *)kCFFTPResourceType];
        
        KPFileEntity *entity;
        
        // DT_DIR
        if ([type isEqualToNumber:@4]) {
            
            entity = [KPDirEntity MR_createEntity];
            KPDirEntity *dirEntity = (KPDirEntity *)entity;
            dirEntity.isDir = @YES;
            NSString *depPath = [path stringByAppendingPathComponent:name];
            NSArray <KPFileEntity *> *entities = [self parserWithPath:depPath parentDirEntity:dirEntity];
            if (entities) {
                dirEntity.subFiles = [NSSet setWithArray:entities];
            }
            
        } else if ([type isEqualToNumber:@8]) {
            NSString *format = [[name componentsSeparatedByString:@"."] lastObject];
            if([[KPFileTypeManager acceptableVideoFormats] containsObject:format]) {
                
                entity = [KPVideoEntity MR_createEntity];
                KPVideoEntity *videoEntity = (KPVideoEntity *)entity;
                videoEntity.format = format;
            }
        }
        
        entity.parentDirName = [[path componentsSeparatedByString:@"/"] lastObject];
        entity.parentDir = parentDirEntity;
        entity.path = [path stringByAppendingPathComponent:name];
        entity.modDate = modDate;
        entity.name = name;
        entity.owner = owner;
        entity.size = size;
        entity.type = type;
        
        if (entity) [returnFiles addObject:entity];
        
    }];
    
    return returnFiles;
}

- (void)setup
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (![self.configEntity.enabled boolValue]) {
            if(self.userIsNotSetCallback) self.userIsNotSetCallback();
            return;
        }
        
        
        NSArray <KPFileEntity *> *eneityDataArray;
        
        eneityDataArray =  [self parserWithPath:nil parentDirEntity:nil];
#ifdef DEBUG
        NSLog(@"%@", eneityDataArray);
        NSLog(@"%@", NSHomeDirectory());
#endif
        
        if (eneityDataArray.count > 0) {
            NSManagedObjectContext *bgContext = [NSManagedObjectContext MR_context];
            [KPFileEntity MR_truncateAllInContext:bgContext];
            [bgContext MR_saveToPersistentStoreAndWait];
        }
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        if (self.loadDataCallback) self.loadDataCallback(eneityDataArray);
    });
}

@end
