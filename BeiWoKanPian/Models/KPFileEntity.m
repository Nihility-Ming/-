//
//  KPFileEntity.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPFileEntity.h"
#import "KPDirEntity.h"
#import "KPUserConfigEntity.h"

@interface KPFileEntity()


@end

@implementation KPFileEntity

- (NSString *)absoluteURLStr
{
    NSArray *ports = @[@"http", @"https"];
    NSString *protocol = ports[[KPUserConfigEntity sharedInstance].HTTPProtocolType];
    NSString *host = [NSString stringWithFormat:@"%@:%@", [KPUserConfigEntity sharedInstance].url, [KPUserConfigEntity sharedInstance].http_port];
    NSString *path = [[KPUserConfigEntity sharedInstance].path stringByAppendingPathComponent:self.path];
    NSURL *URL = [[NSURL alloc] initWithScheme:protocol host:host path:path];
    return [URL absoluteString];
}

@end
