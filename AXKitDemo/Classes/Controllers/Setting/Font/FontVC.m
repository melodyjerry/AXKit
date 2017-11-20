//
//  FontVC.m
//  AXKit
//
//  Created by xaoxuu on 28/05/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "FontVC.h"
#import "FontTableView.h"

@interface FontVC ()

@end

@implementation FontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}


- (AXTableViewType *)installTableView{
    CGRect frame = self.view.bounds;
    return [[FontTableView alloc] initWithFrame:frame];
}


@end
