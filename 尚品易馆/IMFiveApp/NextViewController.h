//
//  NextViewController.h
//  IMFiveApp
//
//  Created by 王圆圆 on 14-11-4.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : QHBasicViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *title;


-(id) initWithUrl:(NSString *)url title:(NSString *)title;

@end
