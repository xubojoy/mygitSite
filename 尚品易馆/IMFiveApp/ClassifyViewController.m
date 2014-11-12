//
//  ContactsViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ClassifyViewController.h"

#import "MainTabViewController.h"
#import "Constant.h"

@interface ClassifyViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
{
    
    NSMutableArray *_arData;
    NSArray *_arKey;
    NSMutableDictionary *_dicData;
    NSMutableDictionary *_dicShowRow;
    
    UIView *_tableHeaderV;
    UISearchBar *_searchB;
    UISearchDisplayController *_searchDisplayC;
    
    NSArray *_arMenuData;
}

@end

@implementation ClassifyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webView removeFromSuperview];
    [self initWebView];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createNavWithTitle:@"尚品易馆" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
         }
         return nil;
     }];
//
//    [self initWebView];
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
    NSURL *nsurl =[NSURL URLWithString:@"http://www.spyg.com.cn/app/cat_all.php"];
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
