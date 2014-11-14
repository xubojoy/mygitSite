//
//  SearchDetailController.m
//  IMFiveApp
//
//  Created by myStyle on 14-11-11.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SearchDetailController.h"
#import "SliderViewController.h"
#import "SearchViewController.h"
@interface SearchDetailController ()

@end

@implementation SearchDetailController

-(id) initWithUrl:(NSString *)url title:(NSString *)title{
    self = [self init];
    if (self) {
        self.url = url;
        self.title = title;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.webView removeFromSuperview];
//    [self initWebView];
    
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createNavWithTitle:self.title createMenuItem:^UIView *(int nIndex)
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
             [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
             return btn;
         }
         return nil;
     }];
//    [[MainTabViewController getMain] initTabbar];
    [self initWebView];
}
- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController].navigationController popViewControllerAnimated:YES];
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
    NSLog(@">>>>>>>>self.url>>>>>>%@",self.url);
    [self.webView setDelegate:self];
    NSURL *nsurl =[NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.view bringSubviewToFront:self.navView];
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
    NSLog(@">>>> web load error:%@", error.description);
    
}

@end
