//
//  KPNetworkWarninger.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/4/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPNetworkWarninger : NSObject

+ (instancetype)sharedWarninger;

@property (assign, nonatomic, readonly, getter=isMonitoring) BOOL monitoring;

- (void)startMonitor;

- (void)stopMonitor;

@end
