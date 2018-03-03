//
//  DebugTV.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "DebugTV.h"
#import <AXCameraKit/AXCameraKit.h>

@implementation DebugTV

- (AXTableModelType *)ax_tableViewPreloadDataSource{
    AXTableModelType *model = [self loadDataSourceFromPath:[service.cache cacheForClassWithName:NSStringFromClass(self.class)]];
    if (!model) {
        model = [self loadDataSourceFromBundle];
    }
    return model;
}

- (void)ax_tableView:(AXTableViewType *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath model:(AXTableRowModelType *)model{
    if ([model.target isEqualToString:@"camera"]) {
        AXCameraViewController *vc = [[AXCameraViewController alloc] init];
        [self.controller presentViewController:vc animated:YES completion:^{
            
        }];
    } else if ([model.target isEqualToString:@"error"]) {
        [NSUserDefaults ax_readStringForKey:@"123" completion:^(NSString * _Nonnull string) {
            AXLogSuccess();
        } failure:^(NSError * _Nonnull error) {
            AXLogFailure();
        }];
    } else {
        [super ax_tableView:tableView didSelectedRowAtIndexPath:indexPath model:model];
    }
}



- (void)ax_tableViewDidLoadFinished:(UITableView<AXTableView> *)tableView{
    tableView.tableFooterView = UIViewWithHeight(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



@end
