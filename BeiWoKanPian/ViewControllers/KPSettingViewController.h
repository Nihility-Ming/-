//
//  KPSettingViewController.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/4/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPSettingViewController : UITableViewController

@property (copy, nonatomic) void(^doneSettingCallback)(KPSettingViewController *vc);

@end
