//
//  KPHomeTableViewCell.h
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPFileEntity.h"

@interface KPHomeTableViewCell : UITableViewCell

- (void)updateWithEntity:(KPFileEntity *)entity;

+ (CGFloat)height;

@end
