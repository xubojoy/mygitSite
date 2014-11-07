//
//  SearchViewController.m
//  IMFiveApp
//
//  Created by 王圆圆 on 14-11-5.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SearchViewController.h"
#import "SliderViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createNavWithTitle:@"搜索" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             UIImage *i = [QHCommonUtil imageNamed:@"menu_icon_bulb.png"];
             [btn setImage:i forState:UIControlStateNormal];
             [btn setFrame:CGRectMake(10, (self.navView.height - i.size.height)/2, i.size.width, i.size.height)];
             [btn setImage:[QHCommonUtil imageNamed:@"menu_icon_bulb_pressed.png"] forState:UIControlStateSelected];
             btn.tag = 989;
             [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
             return btn;
         }
         return nil;
     }];
    
    [self initWebView];
}

- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController].navigationController popToRootViewControllerAnimated:YES];
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
    NSURL *nsurl =[NSURL URLWithString:@"http://www.spyg.com.cn/app/search.php"];
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
