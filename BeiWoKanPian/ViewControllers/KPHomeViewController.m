//
//  KPHomeViewController.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/3/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPHomeViewController.h"
#import <MBProgressHUD+BWMExtension.h>
#import <RealReachability.h>
#import <kxmovie/KxMovieViewController.h>
#import "KPDataLoader.h"
#import "KPDataReader.h"
#import "KPUserConfigEntity.h"
#import "KPHomeTableViewCell.h"
#import "KPSettingViewController.h"
#import "UIScrollView+JZTExtension.h"
#import <RealReachability.h>

static NSString * const kHomeTitle = @"被窝看片";
static NSString * const kCellIdentity = @"KPHomeTableViewCell";
static NSString * const kLoadDataSuccessMsgFormat = @"本次共获取到共%@文件，其中有%@个文件夹和%@个视频.";

@interface KPHomeViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    MPMoviePlayerViewController *_playerViewController;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray <KPFileEntity *> *dataArray;

@end

@implementation KPHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![self.title isEqualToString:kHomeTitle]) {
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
    
    self.tableView.jzt_allowDisplayEmptyDataSetView = YES;
    self.tableView.tableFooterView = [UIView new];
    
    [KPDataReader checkCanRead:^(BOOL can) {
        if (can) {
            [self readData];
            
            // 如果开启自动刷新数据选项
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if ([[KPUserConfigEntity sharedInstance].is_always_load boolValue]) {
                    [self refreshData:nil];
                }
            });
            
        } else {
            [self showAlertView];
        }
    }];
}

- (IBAction)refreshData:(UIBarButtonItem *)sender
{
    MBProgressHUD *HUD = [MBProgressHUD bwm_showHUDAddedTo:[UIApplication sharedApplication].keyWindow title:kBWMMBProgressHUDMsgLoading];
    HUD.detailsLabelFont = [UIFont systemFontOfSize:10.0f];
    
    KPDataLoader *loader = [[KPDataLoader alloc] init];
    [loader setUserIsNotSetCallback:^{
        [HUD hide:YES];
        [self showAlertView];
    }];
    
    [loader setLoadDataCallback:^(NSArray<KPFileEntity *> *dataArray) {
        if (dataArray.count > 0) {
            HUD.detailsLabelText = [NSString stringWithFormat:kLoadDataSuccessMsgFormat, [KPFileEntity MR_numberOfEntities], [KPDirEntity MR_numberOfEntities], [KPVideoEntity MR_numberOfEntities]];
            [HUD bwm_hideWithTitle:kBWMMBProgressHUDMsgLoadSuccessful hideAfter:3.6f msgType:BWMMBProgressHUDMsgTypeSuccessful];
        } else {
            [HUD bwm_hideWithTitle:kBWMMBProgressHUDMsgNoMoreData hideAfter:kBWMMBProgressHUDHideTimeInterval msgType:BWMMBProgressHUDMsgTypeWarning];
        }
        [self readData];
    }];
    
    [loader setup];
}


- (void)readData
{
    KPDataReader *reader = [[KPDataReader alloc] init];
    reader.parentDirName = self.parentDirName;
    
    [reader loadData:^(NSArray<KPFileEntity *> *dataArray) {
        self.dataArray = dataArray;
        [self.tableView reloadData];
    }];
}

#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.cancelButtonIndex == buttonIndex) {
        KPSettingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KPSettingViewController class])];
        [vc setDoneSettingCallback:^(KPSettingViewController *settingViewController) {
            [self refreshData:nil];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark- UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return [KPHomeTableViewCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    [cell updateWithEntity:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPFileEntity *entity = self.dataArray[indexPath.row];
    if ([entity.isDir boolValue]) {
        KPHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
        vc.title = entity.name;
        vc.parentDirName = entity.name;
        [self.navigationController pushViewController:vc animated:YES];
    } else  {

        NSLog(@"%@", entity.absoluteURLStr);
        KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:entity.absoluteURLStr parameters:nil];
        [vc play];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark- Other Methods

- (void)showAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请先配置" message:@"您还未配置HTTP/FTP等信息..." delegate:self cancelButtonTitle:@"前往设置" otherButtonTitles:@"取消", nil];
    [alertView show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isMemberOfClass:[KPSettingViewController class]]) {
        KPSettingViewController *vc = (KPSettingViewController *)segue.destinationViewController;
        [vc setDoneSettingCallback:^(KPSettingViewController *settingViewController) {
            [self refreshData:nil];
        }];
    }
}


@end
