//
//  AccountViewController.h
//  IMFiveApp
//
//  Created by 王圆圆 on 14-11-4.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : QHBasicViewController<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong) NetProcessor *netProcessor;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
