//
//  ReleaseLogTV.m
//  AXKit
//
//  Created by xaoxuu on 29/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "ReleaseLogTV.h"
#import "BaseWebVC.h"

@implementation ReleaseLogTV


- (void)setupTableViewDataSource:(void (^)(NSMutableArray<BaseTableModelSection *> *))dataSource{
    
    [services.git getReleaseLogList:^(GitHubIssueListModel *issues) {
        NSMutableArray<BaseTableModelSection *> *sections = [NSMutableArray array];
        // @xaoxuu: first section
        BaseTableModelSection *sec = [BaseTableModelSection new];
        BaseTableModelRow *row = [BaseTableModelRow new];
        GitHubIssueModel *issue = issues.items.firstObject;
        row.title = issue.title;
        row.cmd = issue.html_url;
        [sec.rows addObject:row];
        sec.header_height = @"44";
        
        sec.header_title = NSLocalizedString(@"最新版本:", nil);
        // sec.footer_title = issue.body;
        [sections addObject:sec];
        // @xaoxuu: others
        [issues.items removeFirstObject];
        BaseTableModelSection *sec2 = [BaseTableModelSection new];
        sec2.header_height = @"44";
        sec2.header_title = NSLocalizedString(@"历史版本", nil);
        for (GitHubIssueModel *issue in issues.items) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = issue.title;
            row.cmd = issue.html_url;
            [sec2.rows addObject:row];
        }
        [sections addObject:sec2];
        if (dataSource) {
            dataSource(sections);
        }
    }];
    
    /*
    [services.git getReleaseList:^(NSMutableArray<GitHubReleaseModel *> *releaseList) {
        NSMutableArray<BaseTableModelSection *> *sections = [NSMutableArray array];
        // @xaoxuu: first section
        BaseTableModelSection *sec = [BaseTableModelSection new];
        BaseTableModelRow *row = [BaseTableModelRow new];
        GitHubReleaseModel *release = releaseList.firstObject;
        row.title = release.name;
        row.cmd = release.html_url;
        NSUInteger len = fmin(10, release.body.length);
        row.desc = [release.body substringToIndex:len];
        [sec.rows addObject:row];
        sec.header_height = @"44";
        
        sec.header_title = [NSString stringWithFormat:NSLocalizedString(@"最新版本: %@", nil), services.app.latestVersion.name];
        
        
        [sections addObject:sec];
        // @xaoxuu: others
        [releaseList removeFirstObject];
        BaseTableModelSection *sec2 = [BaseTableModelSection new];
        sec2.header_height = @"44";
        sec2.header_title = NSLocalizedString(@"历史版本", nil);
        for (GitHubReleaseModel *release in releaseList) {
            BaseTableModelRow *row = [BaseTableModelRow new];
            row.title = release.name;
            row.cmd = release.html_url;
            NSUInteger len = fmin(10, release.body.length);
            row.desc = [release.body substringToIndex:len];
            [sec2.rows addObject:row];
        }
        [sections addObject:sec2];
        if (dataSource) {
            dataSource(sections);
        }
    }];
     */
}

- (void)indexPath:(NSIndexPath *)indexPath didSelected:(__kindof BaseTableModelRow *)model{
    BaseWebVC *vc = [BaseWebVC webVCWithTitle:model.title URLString:model.cmd];
    [self.controller.navigationController pushViewController:vc animated:YES];
}


@end
