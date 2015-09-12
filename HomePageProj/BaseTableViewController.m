//
//  BaseTableViewController.m
//  HomePageProj
//
//  Created by 苏贵明 on 15/9/10.
//  Copyright (c) 2015年 苏贵明. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize scrollingDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.tag = table_tab;
    self.tableView.contentInset = UIEdgeInsetsMake(back_img_height+bar_height , 0, 0, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollingDelegate respondsToSelector:@selector(tableIsScrolling:)]) {
        [scrollingDelegate tableIsScrolling:scrollView.contentOffset.y];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
