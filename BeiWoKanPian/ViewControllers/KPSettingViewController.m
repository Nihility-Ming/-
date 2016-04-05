//
//  KPSettingViewController.m
//  BeiWoKanPian
//
//  Created by 伟明 毕 on 4/4/16.
//  Copyright © 2016 Nihility-Ming. All rights reserved.
//

#import "KPSettingViewController.h"
#import "KPUserConfigEntity.h"
#import "KPNotificationCenterKey.h"

@interface KPSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *urlTF;
@property (weak, nonatomic) IBOutlet UITextField *pathTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *httpSG;
@property (weak, nonatomic) IBOutlet UITextField *httpPortTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ftpSG;
@property (weak, nonatomic) IBOutlet UITextField *ftpPortTF;
@property (weak, nonatomic) IBOutlet UITextField *ftpUserNameTF;
@property (weak, nonatomic) IBOutlet UITextField *ftpPasswordTF;
@property (weak, nonatomic) IBOutlet UISwitch *autoRefreshDataSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *openTouchID;

@end

@implementation KPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[KPUserConfigEntity sharedInstance].enabled boolValue]) {
        self.urlTF.text = [KPUserConfigEntity sharedInstance].url;
        self.pathTF.text = [KPUserConfigEntity sharedInstance].path;
        self.httpSG.selectedSegmentIndex = [KPUserConfigEntity sharedInstance].HTTPProtocolType;
        self.httpPortTF.text = [[KPUserConfigEntity sharedInstance].http_port stringValue];
        self.ftpSG.selectedSegmentIndex = [KPUserConfigEntity sharedInstance].FTPProtocolType;
        self.ftpPortTF.text = [[KPUserConfigEntity sharedInstance].ftp_port stringValue];
        self.ftpUserNameTF.text = [KPUserConfigEntity sharedInstance].ftp_username;
        self.ftpPasswordTF.text = [KPUserConfigEntity sharedInstance].ftp_password;
        self.autoRefreshDataSwitch.on = [[KPUserConfigEntity sharedInstance].is_always_load boolValue];
        self.openTouchID.on = [[KPUserConfigEntity sharedInstance].is_open_touchid boolValue];
    }
}

- (IBAction)done:(UIBarButtonItem *)sender {
    [KPUserConfigEntity sharedInstance].url = self.urlTF.text;
    [KPUserConfigEntity sharedInstance].path = self.pathTF.text;
    [KPUserConfigEntity sharedInstance].http_protocol = @(self.httpSG.selectedSegmentIndex);
    [KPUserConfigEntity sharedInstance].http_port = @([self.httpPortTF.text intValue]);
    [KPUserConfigEntity sharedInstance].ftp_protocol = @(self.ftpSG.selectedSegmentIndex);
    [KPUserConfigEntity sharedInstance].ftp_port = @([self.ftpPortTF.text intValue]);
    [KPUserConfigEntity sharedInstance].ftp_username = self.ftpUserNameTF.text;
    [KPUserConfigEntity sharedInstance].ftp_password = self.ftpPasswordTF.text;
    [KPUserConfigEntity sharedInstance].enabled = @YES;
    [KPUserConfigEntity sharedInstance].is_always_load = @(self.autoRefreshDataSwitch.on);
    [KPUserConfigEntity sharedInstance].is_open_touchid = @(self.openTouchID.on);
    
    if ([self.httpPortTF.text intValue] == 0) {
        [KPUserConfigEntity sharedInstance].http_port = @80;
    }
    
    if ([self.ftpPortTF.text intValue] == 0) {
        [KPUserConfigEntity sharedInstance].ftp_port = @21;
    }
    
    if (self.pathTF.text.length == 0) {
        [KPUserConfigEntity sharedInstance].path = @"/";
    }
    
    [[KPUserConfigEntity sharedInstance] save];
    
    if (self.doneSettingCallback) {
        self.doneSettingCallback(self);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserDidChangedSettingNotificationKey object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)textFieldDidEndOneExit:(UITextField *)sender {
    [sender resignFirstResponder];
}


@end
