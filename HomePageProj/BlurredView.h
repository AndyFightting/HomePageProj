//
//  BlurredView.h
//  Persona
//
//  Created by Aaron Ng (@aaronykng) on 2/22/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+BoxBlur.h"

@interface BlurredView : UIView


@property (assign) CGFloat roundingValue; //值越大要滚动越多才会有变化，相反值越小滚动一点变化就很大了!默认值是 8。
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong) UIColor *blurTintColor;
@property (assign) CGFloat startTintAlpha;
@property (assign) CGFloat endTintAlpha;

//滚动渐变调用方法
-(void)updateBlurringWithFloatValue:(CGFloat)floatValue;

//时间渐变调用
-(void)updateBlurringDuringSecond:(CGFloat)second;

@end
