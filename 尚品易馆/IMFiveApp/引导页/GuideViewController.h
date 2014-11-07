//
//  GuideViewController.h
//  Gastrointestinal Health
//
//  Created by 巩鑫 on 14-9-11.
//  Copyright (c) 2014年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderViewController.h"

@interface GuideViewController : UIViewController<UIScrollViewDelegate>
{
    //立即体验按钮
    UIButton * btn;
   //滚动视图
    UIScrollView * scrollview;
    //PageContro
    UIPageControl * pc;
    
    
}
@property (strong,nonatomic) SliderViewController *revealSlideViewController;
@end
