//
//  MessagesViewController.m
//  IMApp
//
//  Created by chen on 14-7-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "IndexViewController.h"
#import "MainTabViewController.h"
//#import "RectViewForMessage.h"
#import "SearchViewController.h"

@interface IndexViewController ()
{

    UITapGestureRecognizer *_tapGestureRec;
    
    UIView *_maskV;
}

@end

@implementation IndexViewController

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
    
    [self createNavWithTitle:@"主页" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             UIImage *i = [QHCommonUtil imageNamed:@"nav_menu_icon"];
             [btn setImage:i forState:UIControlStateNormal];
             [btn setFrame:CGRectMake(10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [btn setImage:[QHCommonUtil imageNamed:@"nav_menu_icon"] forState:UIControlStateSelected];
             btn.tag = 989;
             [btn addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
             return btn;
         }
         return nil;
     }];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *i = [QHCommonUtil imageNamed:@"nav_menu_icon"];
    [btn1 setImage:i forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(290, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
    [btn1 setImage:[QHCommonUtil imageNamed:@"nav_menu_icon"] forState:UIControlStateSelected];
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

-(void) initWebView{
    self.webView = [[UIWebView alloc] init];
    if (IOS_6) {
        self.webView.frame = CGRectMake(0, 44, 320, self.view.frame.size.height-44-49);
    }
    self.webView.frame = CGRectMake(0, 64, 320, self.view.frame.size.height-64-49);
    
    
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

#pragma mark - Actions

- (void)showLeft:(UIButton *)sender {
     [[SliderViewController sharedSliderController] showLeftViewController];
}

-(void)searchBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>>>>>>>search");
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







@end
