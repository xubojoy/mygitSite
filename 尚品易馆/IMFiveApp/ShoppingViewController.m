//
//  DynamicViewController.m
//  IMApp
//
//  Created by chen on 14-7-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ShoppingViewController.h"
#import "SearchViewController.h"
#import "SliderViewController.h"
@interface ShoppingViewController ()
{
    NSMutableArray *_arData;
}

@end

@implementation ShoppingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView removeFromSuperview];
    [self initWebView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addObserver];
    
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
    //注册联网状态的通知监听器
    self.netProcessor = [NetProcessor new];
    [self.netProcessor initNet];
    
}

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
    NSURL *nsurl =[NSURL URLWithString:@"http://www.spyg.com.cn/app/flow.php?step=cart"];
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

@end
