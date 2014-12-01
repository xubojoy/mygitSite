//
//  GuideViewController.h
//  Gastrointestinal Health

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
