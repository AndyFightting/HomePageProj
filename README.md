# HomePageProj
模仿新浪微博的个人主页，用ViewController而不是tableView。这样的的组织结构就像Android的Fragment，各自item项里的数据在各自的Contoller里处理。

添加了导航模糊渐变处理，用[ANBlurredTableView](https://github.com/aaronn/ANBlurredTableView)改的，它和tableView耦合了，改了改独立成了UIView,使用简单方便，效果也不错！

![图片](https://github.com/AndyFightting/HomePageProj/blob/master/simple.gif)
![图片](https://github.com/AndyFightting/HomePageProj/blob/master/simple2.gif)

```
  //使用：
    BlurredView* blurredView = [[BlurredView alloc]initWithFrame:CGRectMake(0, 0, 100,100)];
    [blurredView setBackgroundImage:backImg];
    [self.view addSubview:blurredView];
  //然后在 scrollViewDidScroll：方法中调用如下方法
    [blurredView updateBlurringWithFloatValue:contentOffSet.y]; //传 y<=0 的值！越小越模糊
  
  //或者在时间范围内渐变调用
  [blurredView updateBlurringDuringSecond:0.5];
    
    
```
