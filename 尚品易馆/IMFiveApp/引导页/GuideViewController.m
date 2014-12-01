//
//  GuideViewController.m
//  Gastrointestinal Health

#import "GuideViewController.h"
#import "Macro.h"
#import "IndexViewController.h"
@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];
    
    
}
-(void)initGuide
{
    //滚动视图
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT_VIEW(self.view))];
    [scrollview setContentSize:CGSizeMake(960, 0)];
    [scrollview setPagingEnabled:YES];
    [scrollview setBounces:NO];
    scrollview.showsVerticalScrollIndicator =NO;
    scrollview.delegate = self;
    
    UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, CGRectGetHeight(scrollview.frame))];
    imageview1.backgroundColor = GXRandomColor;

    UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, CGRectGetHeight(scrollview.bounds))];
    imageview2.backgroundColor = GXRandomColor;

    UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(640, 0, 320, CGRectGetHeight(scrollview.frame))];
    imageview3.backgroundColor =GXRandomColor;
    imageview3.userInteractionEnabled = YES;
    if (DEVICE_IS_IPHONE5) {
        [imageview1 setImage:[UIImage imageNamed:@"scroll_1@2x"]];
        [imageview2 setImage:[UIImage imageNamed:@"scroll_2@2x"]];
        [imageview3 setImage:[UIImage imageNamed:@"scroll_3@2x"]];
    }else{
        [imageview1 setImage:[UIImage imageNamed:@"scroll_1"]];
        [imageview2 setImage:[UIImage imageNamed:@"scroll_2"]];
        [imageview3 setImage:[UIImage imageNamed:@"scroll_3"]];
    }
    [scrollview addSubview:imageview1];
    [scrollview addSubview:imageview2];
    [scrollview addSubview:imageview3];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-150,CGRectGetHeight(self.view.frame)-125, 300, 50)];
    lable.backgroundColor = [UIColor clearColor];
    
    lable.textColor = [[ UIColor whiteColor] colorWithAlphaComponent:0.8];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont fontWithName:@"Helvetica" size:30.0f];
    [imageview3 addSubview:lable];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [btn setBackgroundImage:[UIImage imageNamed:@"Btn_orange"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Firstpressed) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageview3 addSubview:btn];

    
//    UIPageControl*page=[[UIPageControl alloc]init];
//    page.frame=CGRectMake(140, CGRectGetHeight(self.view.frame)-40, 45, 30);
//    page.pageIndicatorTintColor = HexRGBAlpha(0x4fb4d9, 1);
//    page.currentPageIndicatorTintColor = HexRGBAlpha(0xf2fbfb, 1);
//    page.numberOfPages=3;
//    page.currentPage=0;
//    page.tag = 100;
//    page.userInteractionEnabled=NO;
    [self.view addSubview:scrollview];
//    [self.view addSubview:page];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UIPageControl* page = (UIPageControl*)[self.view viewWithTag:100];
//    int current = scrollView.contentOffset.x/320;
//    page.currentPage = current;
}

-(void)Firstpressed
{
    [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = naviC;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
