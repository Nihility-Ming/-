//
//  AppDelegate.m
//  BeiWoKanPian
//
//  Created by 找塑料 on 16/4/1.
//  Copyright © 2016年 Nihility-Ming. All rights reserved.
//

#import "AppDelegate.h"
#import "KPCoreDataManager.h"
#import "KPNetworkWarninger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [KPCoreDataManager setup];
    [[KPNetworkWarninger sharedWarninger] startMonitor];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [KPCoreDataManager cleanUp];
}

@end
