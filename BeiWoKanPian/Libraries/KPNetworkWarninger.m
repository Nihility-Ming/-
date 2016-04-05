//
//  KPNetworkWarninger.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/4/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPNetworkWarninger.h"
#import <RealReachability.h>
#import <JDStatusBarNotification.h>
#import "KPUserConfigEntity.h"
#import "KPNotificationCenterKey.h"

@interface KPNetworkWarninger()

@property (assign, nonatomic, getter=isMonitoring) BOOL monitoring;


@end

@implementation KPNetworkWarninger

+ (instancetype)sharedWarninger
{
    static KPNetworkWarninger *_warninger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _warninger = [[self alloc] init];
    });
    
    return _warninger;
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidChangedSettingNotification:) name:kUserDidChangedSettingNotificationKey object:nil];
    }
    
    return self;
}

- (void)userDidChangedSettingNotification:(NSNotification *)notification
{
    if (!self.monitoring) {
        [self startMonitor];
    } else {
        GLobalRealReachability.hostForPing = [KPUserConfigEntity sharedInstance].url;
    }
}

- (void)startMonitor
{
    if (![[KPUserConfigEntity sharedInstance].enabled boolValue]) {
        return;
    }
    
    self.monitoring = YES;
    
    [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle *style) {
        style.barColor = [UIColor darkGrayColor];
        style.textColor = [UIColor whiteColor];
        style.animationType = JDStatusBarAnimationTypeBounce;
        return style;
    }];
    
    GLobalRealReachability.hostForPing = [KPUserConfigEntity sharedInstance].url;
    [GLobalRealReachability startNotifier];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    
    
}

- (void)stopMonitor
{
    [GLobalRealReachability  stopNotifier];
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    
    NSString *msg = nil;

    switch (status)
    {
        case RealStatusNotReachable:
        {
            msg = @"基友提示：您似乎与目标主机断开了连接。 :(";
            break;
        }
        case RealStatusViaWWAN:
        {
            msg = @"基友提示：您正在使用2G/3G/4G网络，请注意看片流量。";
            break;
        }
            
        case RealStatusViaWiFi:
        {
            msg = @"基友提示：您正在使用WiFi高速上网，使劲看片就对了！";
            break;
        }
            
        default:
            break;
    }
    
    if (![JDStatusBarNotification isVisible]) {
        [JDStatusBarNotification showWithStatus:msg dismissAfter:3.5f];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserDidChangedSettingNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRealReachabilityChangedNotification object:nil];
}

@end
