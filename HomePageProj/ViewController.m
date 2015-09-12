//
//  ViewController.m
//  HomePageProj
//
//  Created by 苏贵明 on 15/9/10.
//  Copyright (c) 2015年 苏贵明. All rights reserved.
//

#import "ViewController.h"
#import "HomePageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Hello World";
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:nil];
    
    
    UIButton* bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    bt.center = self.view.center;
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt setTitle:@"进入个人主页" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(btTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
}

-(void)btTap:(UIButton*)bt{

    [self.navigationController pushViewController:[[HomePageViewController alloc]init] animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
