//
//  MessagesViewController.h
//  IMApp
//
//  Created by chen on 14-7-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHBasicViewController.h"
#import "SliderViewController.h"

@interface IndexViewController : QHBasicViewController<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
