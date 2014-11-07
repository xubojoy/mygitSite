//
//  DynamicViewController.h
//  IMApp
//
//  Created by chen on 14-7-21.
//  Copyright (c) 2014年 chen. All rights reserved.
//

@interface ShoppingViewController : QHBasicViewController<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
