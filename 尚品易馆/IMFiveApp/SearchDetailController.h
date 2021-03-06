//
//  SearchDetailController.h
//  IMFiveApp
//
//  Created by myStyle on 14-11-11.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabViewController.h"

@interface SearchDetailController : QHBasicViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *title;

-(id) initWithUrl:(NSString *)url title:(NSString *)title;

@end
