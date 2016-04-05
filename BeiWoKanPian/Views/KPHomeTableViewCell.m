//
//  KPHomeTableViewCell.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPHomeTableViewCell.h"

static NSString * const kMovieImageNamed = @"movie_icon";
static NSString * const kFolderImageNamed = @"folder_icon";

@interface KPHomeTableViewCell()
{
    NSDateFormatter *_formatter;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *modDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (strong, nonatomic) UIImage *movieIcon;
@property (strong, nonatomic) UIImage *folderIcon;

@end

@implementation KPHomeTableViewCell

- (UIImage *)movieIcon
{
    if (!_movieIcon) {
        _movieIcon = [UIImage imageNamed:kMovieImageNamed];
    }
    
    return _movieIcon;
}

- (UIImage *)folderIcon
{
    if (!_folderIcon) {
        _folderIcon = [UIImage imageNamed:kFolderImageNamed];
    }
    
    return _folderIcon;
}

- (void)awakeFromNib {
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
}

- (void)updateWithEntity:(KPFileEntity *)entity
{
    // 图标
    if ([entity.isDir boolValue]) {
        self.iconImageView.image = self.folderIcon;
        self.sizeLabel.text = @"大小: --";
    } else {
        self.iconImageView.image = self.movieIcon;
        // 大小
        NSString *sizeStr = nil;
        double MB = [entity.size doubleValue] / 1024 / 1024;
        if (MB >= 1024.0) {
            sizeStr = [NSString stringWithFormat:@"%.2f GB", MB/1024];
        } else {
            sizeStr = [NSString stringWithFormat:@"%.2f MB", MB];
        }
        self.sizeLabel.text = [@"大小: "  stringByAppendingString:sizeStr];
    }
    
    // 标题
    self.titleLabel.text = entity.name;
    
    // 修改日期
    NSString *dateStr = [_formatter stringFromDate:entity.modDate];
    self.modDateLabel.text = [@"修改日期: " stringByAppendingString:dateStr];

}

+ (CGFloat)height
{
    return 92.0f;
}

@end
