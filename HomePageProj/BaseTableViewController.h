//
//  BaseTableViewController.h
//  HomePageProj
//
//  Created by 苏贵明 on 15/9/10.
//  Copyright (c) 2015年 苏贵明. All rights reserved.
//


#define view_width [UIScreen mainScreen].bounds.size.width
#define view_height [UIScreen mainScreen].bounds.size.height

//16进制颜色 UIColorFromRGB(0xf48800)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define title_height 64
#define back_img_height 200
#define bar_height 45

#define table_tab 9527

#import <UIKit/UIKit.h>

@protocol ScrollingDelegate <NSObject>
-(void)tableIsScrolling:(float)offSetY;
@end

@interface BaseTableViewController : UITableViewController

@property(nonatomic,retain)id<ScrollingDelegate> scrollingDelegate;

@end
