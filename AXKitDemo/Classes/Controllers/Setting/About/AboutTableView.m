//
//  AboutTableView.m
//  AXKit
//
//  Created by xaoxuu on 20/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "AboutTableView.h"
#import "NormalLabel.h"
#import "BaseWebVC.h"
#import "BlogVC.h"

#define CACHE_VERSION @"CACHE_VERSION"


static CGFloat const iconSize = 64;
@interface AboutTableView ()



@end

@implementation AboutTableView



- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 3 / 4)];
    
    // @xaoxuu: icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconSize, iconSize)];
    icon.image = [NSBundle ax_appIcon];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    // @xaoxuu: layer
    icon.backgroundColor = [UIColor whiteColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = icon.width/4.2;
    // @xaoxuu: point
    icon.center = view.boundsCenter;
    [view addSubview:icon];
    
    // @xaoxuu: app name
    NormalLabel *appName = [NormalLabel labelWithTitle:[NSBundle ax_appDisplayName] fontSize:12];
    appName.centerX = 0.5 * view.width;
    appName.top = icon.bottom + 8;
    [view addSubview:appName];
    
    tableView.tableHeaderView = view;
//    tableView.tableFooterView = services.app.copyrightTableFooter;
}

- (void)ax_tableViewCell:(AXTableViewCellType *)cell willSetModel:(AXTableRowModelType *)model forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 应该放在didLoad里面
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    UIVisualEffectView *vev = [[UIVisualEffectView alloc] initWithFrame:cell.bounds];
    UIVisualEffect *ve = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    vev.effect = ve;
    cell.backgroundView = vev;
    
    
    AXTableRowModel *tmp = (AXTableRowModel *)model;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            tmp.detail = [NSBundle ax_appVersion];
//            tmp.detail = [NSUserDefaults ax_readStringForKey:CACHE_VERSION];
//            VersionLaterThanVersion([NSBundle ax_appVersion], services.app.remoteVersion.name, ^(BOOL later) {
//                if (later) {
//                    model.detail = [NSString stringWithFormat:@"%@ beta (%@)", [NSBundle ax_appVersion], [NSBundle ax_appBuild]];
//                } else {
//                    model.detail = [NSString stringWithFormat:@"%@ (%@)", [NSBundle ax_appVersion], [NSBundle ax_appBuild]];
//                }
//                [NSUserDefaults ax_setString:model.desc forKey:CACHE_VERSION];
//            }, nil);
            AXLogOBJ(model.detail);
        } else if (indexPath.row == 1) {
            NSString *buildTime = @"2018".append([NSBundle ax_appBuild]);
            NSDate *date = [NSDate dateWithString:buildTime format:@"yyyyMdd1"];
            tmp.detail = [date stringWithFormat:@"yyyy-MM-dd"];
        }
    }
}

- (void)ax_tableViewWillPushToViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath{
    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    if ([viewController isKindOfClass:[BlogVC class]]) {
        BlogVC *vc = (BlogVC *)viewController;
        vc.urlStr = model.detail;
    }
}

- (BOOL)ax_tableViewShouldPushToViewController:(UIViewController *)viewController fromRowAtIndexPath:(NSIndexPath *)indexPath{
//    AXTableRowModelType *model = [self tableViewRowModelForIndexPath:indexPath];
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
//        if ([targetVC isKindOfClass:[BaseWebVC class]]) {
//            BaseWebVC *vc = viewController;
//            vc.urlStr = model.cmd;
//        }
        
    }
    return YES;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return [self sectionModel:section].footer_height.floatValue;
//}


//
//- (void)didDiscoverRemoteVersion:(AppVersionInfoModel *)version{
//    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//}

@end
