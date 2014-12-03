//
//  SearchViewController.m
//  IMFiveApp
//
//  Created by 王圆圆 on 14-11-5.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SearchViewController.h"
#import "SliderViewController.h"
#import "SearchDetailController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "Macro.h"
#import "LeftViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNavWithTitle:@"搜索" createMenuItem:^UIView *(int nIndex)
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

    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, self.navView.frame.size.height, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"请输入关键字"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.height,VIEW_WEIGHT , VIEW_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:mySearchBar];
    dataArray = [NSMutableArray new];
}

- (void)showLeft:(UIButton *)sender {
    
    NSLog(@">>>>>>>>>>>>来啦！！！！");
    [[SliderViewController sharedSliderController].navigationController popToRootViewControllerAnimated:YES];
    [[SliderViewController sharedSliderController] showLeftViewController];
}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return searchResults.count;
//    }
//    else {
        return dataArray.count;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        cell.textLabel.text = searchResults[indexPath.row];
//    }
//    else {
//        cell.textLabel.text = dataArray[indexPath.row];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        SearchDetailController *sdc = [[SearchDetailController alloc] initWithUrl:[NSString stringWithFormat:@"http://www.spyg.com.cn/app/search.php?encode=%@",mySearchBar.text] title:@""];
//        [self.navigationController pushViewController:sdc animated:YES];
//    }
//    else {
//        SearchDetailController *sdc = [[SearchDetailController alloc] initWithUrl:[NSString stringWithFormat:@"http://www.spyg.com.cn/app/search.php?encode=%@",mySearchBar.text] title:@""];
//        [self.navigationController pushViewController:sdc animated:YES];
//    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchDetailController *sdc = [[SearchDetailController alloc] initWithUrl:[NSString stringWithFormat:@"http://www.spyg.com.cn/app/search.php?keywords=%@",[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] title:@""];
    [self.navigationController pushViewController:sdc animated:YES];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    
}

@end
