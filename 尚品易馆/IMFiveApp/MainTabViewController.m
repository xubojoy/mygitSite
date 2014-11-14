//
//  HomePageViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainTabViewController.h"
#import "QHCommonUtil.h"
#import "IndexViewController.h"
#import "ClassifyViewController.h"
#import "ShoppingViewController.h"
#import "AccountViewController.h"
#import "FeedBackViewController.h"
#import "SearchViewController.h"

@interface MainTabViewController ()
{
//    UITabBarController *_tabC;
    
    UITapGestureRecognizer *_tapGestureRec;
    
    UIView *_maskV;
    
    
}

@end

@implementation MainTabViewController

static MainTabViewController *main;

+ (MainTabViewController *)getMain
{
    return main;
}

- (id)init
{
    self = [super init];
    
    main = self;
    
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    UIButton *btn = (UIButton *)self.rightV;
    if (btn.selected)
    {
        [btn setUserInteractionEnabled:NO];
        [btn setSelected:!btn.selected];
        [self showMenuWithBool:btn.selected complete:^()
         {
             [btn setUserInteractionEnabled:YES];
         }];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObserver];
//    [self initTabbar];
    [self createNavWithTitle:@"尚品易馆" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             UIImage *i = [UIImage imageNamed:@"menu_icon_white"];
             [btn setImage:i forState:UIControlStateNormal];
             [btn setFrame:CGRectMake(0, (self.navView.height - i.size.height)/2-10, i.size.width+40, i.size.height+35)];
             btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 25);
             [btn setImage:[UIImage imageNamed:@"menu_icon_red"] forState:UIControlStateSelected];
             btn.tag = 989;
             [btn addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
             return btn;
         }
         return nil;
     }];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *i = [UIImage imageNamed:@"search_wbg"];
    [btn1 setImage:i forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(260, (self.navView.height - i.size.height)/2-10, i.size.width+35, i.size.height+35)];
    [btn1 setImage:[UIImage imageNamed:@"search_bg"] forState:UIControlStateSelected];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 5);
    btn1.tag = 1000;
    [btn1 addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn1];
    
    _maskV = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, self.view.width, self.view.height - self.navView.bottom - self.tabBarController.tabBar.height)];
    [_maskV setClipsToBounds:YES];
    [self.view addSubview:_maskV];
    [_maskV setHidden:YES];
    
    UIView *bg = [[UIView alloc] initWithFrame:_maskV.bounds];
    [bg setBackgroundColor:[UIColor blackColor]];
    [bg setAlpha:0.5];
    [_maskV addSubview:bg];
    
    UITapGestureRecognizer *tSM = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuByTap:)];
    [bg addGestureRecognizer:tSM];
    [self initWebView];
}

- (void)showLeft:(UIButton *)sender {
    [[SliderViewController sharedSliderController] showLeftViewController];
}

-(void)searchBtnClick:(UIButton *)sender{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
     {
         [[SliderViewController sharedSliderController].navigationController pushViewController:svc animated:YES];
     }];
}

- (void)showMenuWithBool:(BOOL)bShow complete:(void(^)())complete
{
    if (bShow)
    {
        [_maskV setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^
         {
             
         } completion:^(BOOL finished)
         {
             complete();
         }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^
         {
             
         } completion:^(BOOL finished)
         {
             [_maskV setHidden:YES];
             complete();
         }];
    }
}

#pragma mark - action

- (void)showMenu:(UIButton *)btn
{
    [btn setUserInteractionEnabled:NO];
    [btn setSelected:!btn.selected];
    
    [self showMenuWithBool:btn.selected complete:^()
     {
         [btn setUserInteractionEnabled:YES];
     }];
}

- (void)showMenuByTap:(UITapGestureRecognizer *)tap
{
    UIButton *btn = (UIButton *)self.rightV;
    [btn setUserInteractionEnabled:NO];
    [btn setSelected:!btn.selected];
    [self showMenuWithBool:btn.selected complete:^()
     {
         [btn setUserInteractionEnabled:YES];
     }];
}

-(void) initWebView{
    self.webView = [[UIWebView alloc] init];
    if (IOS_6) {
        self.webView.frame = CGRectMake(0, 44, 320, self.view.frame.size.height-44);
    }
    self.webView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64);
    
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:self.webView.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [ self.webView addSubview:self.activityIndicator];
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    self.webView.scrollView.decelerationRate = 0.8;
    
    [self.webView setDelegate:self];
    NSURL *nsurl =[NSURL URLWithString:@"http://www.spyg.com.cn/app"];
    NSURLRequest *request =[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)inRequest   navigationType:(UIWebViewNavigationType)inType
{
    
    NSLog(@">>>>> to:%@", inRequest.URL);
    return YES;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@">>>> web load error:%@", webView.request.URL);
    
}





























/*

-(void)initTabbar{
    _tabC = [[UITabBarController alloc] init];
    [_tabC.tabBar setBackgroundColor:[UIColor clearColor]];
    [_tabC.view setFrame:self.view.frame];
    [self.view addSubview:_tabC.view];
    
    IndexViewController *f = [[IndexViewController alloc] init];
    ClassifyViewController *contactsVC = [[ClassifyViewController alloc] init];
    ShoppingViewController *t = [[ShoppingViewController alloc] init];
    AccountViewController *avc = [[AccountViewController alloc] init];
    FeedBackViewController *fbvc = [[FeedBackViewController alloc] init];
    _tabC.viewControllers = @[f, contactsVC, t ,avc ,fbvc];
//    
//    [self reloadImage];
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), NSForegroundColorAttributeName, nil]
//                                             forState:UIControlStateSelected];
    
    [_tabC setSelectedIndex:0];


}

- (void)reloadImage
{
    [super reloadImage];
    [_tabC.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    _tabC.delegate = self;
    NSArray *ar = _tabC.viewControllers;
    NSMutableArray *arD = [NSMutableArray new];
    [ar enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
    {
        UITabBarItem *item = nil;
        switch (idx)
        {
            case 0:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"主页" image:[[UIImage imageNamed:@"index_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"index_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 1:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"分类" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"classify_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"classify_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 2:
            {
                item = [[UITabBarItem alloc]initWithTitle:@"购物" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"shopping_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"shopping_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 3:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"账户" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"account_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"account_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 4:
            {
                item = [[UITabBarItem alloc]initWithTitle:@"客服" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"feed_back_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"feed_back_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
                
        }
        viewController.tabBarItem = item;
        [arD addObject:viewController];
    }];
    _tabC.viewControllers = arD;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = tabBarController.selectedIndex;
    NSLog(@"____________________%ld",index);

    switch (index) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新" object:nil];
            break;
        case 1:

            break;
        case 2:

            break;
        case 3:

            break;
        case 4:

            break;
        default:
            break;
    }
    
}
*/

@end
