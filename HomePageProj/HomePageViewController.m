//
//  HomePageViewController.m
//  HomePageProj
//
//  Created by 苏贵明 on 15/9/10.
//  Copyright (c) 2015年 苏贵明. All rights reserved.
//

#import "HomePageViewController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"

#import "BlurredView.h"

@interface HomePageViewController ()<ScrollingDelegate>

@end

@implementation HomePageViewController{

    UILabel* titleLabel;
    UILabel* moveLabel;
    
    BlurredView* blurredView;//要正方形的背景图片！
    UIView* barBackView;
    
    float barBtWidth;
    float table_ofset;
    
    BlurredView* ss;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    OneTableViewController* oneVC = [[OneTableViewController alloc]init];
    oneVC.scrollingDelegate = self;
    [self addChildViewController:oneVC];
    
    TwoTableViewController* twoVC = [[TwoTableViewController alloc]init];
    twoVC.scrollingDelegate = self;
    [self addChildViewController:twoVC];
    
    ThreeTableViewController* threeVC = [[ThreeTableViewController alloc]init];
    threeVC.scrollingDelegate = self;
    [self addChildViewController:threeVC];

    [self initView];

}


-(void)initView{
    
    // 设置导航条中间view
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"hello world";
    [titleLabel setTextColor:[UIColor colorWithWhite:1 alpha:0]];
    [titleLabel sizeToFit];
    titleLabel.alpha = 0;
    self.navigationItem.titleView = titleLabel;

    [self barBtTaped:nil];
    [self initBackView];
    [self initBarView];
}

-(void)initBackView{
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    UIImage* backImg = [UIImage imageNamed:@"backImg.JPG"];

    blurredView = [[BlurredView alloc]initWithFrame:CGRectMake(0, -(view_width-back_img_height), view_width,view_width)];
    [blurredView setBackgroundImage:backImg];
    blurredView.userInteractionEnabled = YES;
    [self.view addSubview:blurredView];
    
    UITapGestureRecognizer* backImgGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backImgTaped)];
    [blurredView addGestureRecognizer:backImgGes];
    
    UIImageView* headImg = [[UIImageView alloc]initWithFrame:CGRectMake((view_width-80)/2, view_width-150, 80, 80)];
    [headImg setImage:[UIImage imageNamed:@"headImg.JPG"]];
    headImg.layer.cornerRadius = 40;
    headImg.layer.masksToBounds = YES;
    [blurredView addSubview:headImg];

    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,view_width-70 ,view_width ,30 )];
    nameLabel.text = @"阿贵";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [blurredView addSubview:nameLabel];
}

-(void)backImgTaped{
    NSLog(@"背景点击");

}

-(void)initBarView{
    barBtWidth = 60;
    barBackView = [[UIView alloc]initWithFrame:CGRectMake(0, back_img_height, view_width, bar_height)];
    barBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:barBackView];

    NSArray* nameAry = @[@"主页",@"微博",@"相册"];
    for (int i=0; i<3; i++) {
        UIButton* barBt = [[UIButton alloc]initWithFrame:CGRectMake((view_width-barBtWidth*3)/2+barBtWidth*i, 0, barBtWidth, bar_height)];
        [barBt setTitle:nameAry[i] forState:UIControlStateNormal];
        barBt.tag = i;
        barBt.titleLabel.font = [UIFont systemFontOfSize:15];
        [barBt addTarget:self action:@selector(barBtTaped:) forControlEvents:UIControlEventTouchUpInside];
        [barBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [barBackView addSubview:barBt];
    }
    
    UILabel* grayLine = [[UILabel alloc]initWithFrame:CGRectMake(0, bar_height-1, view_width, 1)];
    grayLine.backgroundColor = [UIColor lightGrayColor];
    [barBackView addSubview:grayLine];
    
    moveLabel = [[UILabel alloc]initWithFrame:CGRectMake((view_width-barBtWidth*3)/2+barBtWidth*0, bar_height-2, barBtWidth, 2)];
    moveLabel.backgroundColor =UIColorFromRGB(0xf48800);
    [barBackView addSubview:moveLabel];

}

-(void)barBtTaped:(UIButton*)bt{
    //移除之前的 ViewControll.view
    UIView* tmpView = [self.view viewWithTag:table_tab];
    [tmpView removeFromSuperview];
    
    BaseTableViewController* currentVC = [self.childViewControllers objectAtIndex:(int)bt.tag];
    [self.view addSubview:currentVC.view];
    [currentVC.tableView setContentOffset:CGPointMake(0, table_ofset)];
    
    [self.view bringSubviewToFront:blurredView];
    [self.view bringSubviewToFront:barBackView];
    
    [UIView animateWithDuration:0.25 animations:^{
        [moveLabel setFrame:CGRectMake((view_width-barBtWidth*3)/2+barBtWidth*(int)bt.tag, bar_height-2, barBtWidth, 2)];
    }];
}

#pragma mark - scrolling delegate
-(void)tableIsScrolling:(float)offSetY{
    table_ofset = offSetY;
    
    //位置处理-------
    float tmpY = -offSetY-bar_height;
    if (tmpY < title_height) {
        tmpY = title_height;
    }
    CGRect tmpBarFrame = barBackView.frame;
    tmpBarFrame.origin.y = tmpY;
    barBackView.frame = tmpBarFrame;

    CGRect tmpImgFrame = blurredView.frame;
    tmpImgFrame.origin.y = tmpY-view_width;
    blurredView.frame = tmpImgFrame;
    
    //透明处理-------
    CGFloat alpha =0;
    if (tmpY<=back_img_height) {
        alpha = 1-(tmpY-title_height)/(back_img_height-title_height);
    }else{//透明
        alpha = 0;
    }
    UIColor *alphaColor = [UIColor colorWithWhite:0 alpha:alpha];
    [titleLabel setTextColor:alphaColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0 alpha:alpha];

    
    //方式- **************** 白色导航背景
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    
    //方式二 **************** 模糊导航背景
    [blurredView updateBlurringWithFloatValue:200-tmpY]; //传 <=0 的值！越小越模糊
    
    
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
