//
//  SearchViewController.h
//  IMFiveApp
//
//  Created by 王圆圆 on 14-11-5.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : QHBasicViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{

    NSMutableArray *dataArray;
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
}
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
