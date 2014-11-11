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

@interface SearchViewController ()

@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self initWebView];
}
//- (void) viewDidLoad
//{
//    [super viewDidLoad];
//    [self createNavWithTitle:@"搜索" createMenuItem:^UIView *(int nIndex)
//     {
//         if (nIndex == 1)
//         {
//             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//             UIImage *i = [UIImage imageNamed:@"menu_icon_white"];
//             [btn setImage:i forState:UIControlStateNormal];
//             [btn setFrame:CGRectMake(0, (self.navView.height - i.size.height)/2-10, i.size.width+40, i.size.height+35)];
//             btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 25);
//             [btn setImage:[UIImage imageNamed:@"menu_icon_red"] forState:UIControlStateSelected];
//
//             btn.tag = 989;
//             [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//             return btn;
//
//         }
//         return nil;
//     }];
//    
////    [self initWebView];
//}
//
//- (void)backAction:(UIButton *)btn
//{
//    [[SliderViewController sharedSliderController].navigationController popToRootViewControllerAnimated:YES];
//}


- (void)viewDidLoad
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

    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.height,VIEW_WEIGHT , VIEW_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor purpleColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = mySearchBar;
    [self.view addSubview:self.tableView];
    dataArray = [@[@"衣服",@"百度",@"六六",@"谷歌",@"苹果",@"and",@"table",@"view",@"and",@"and",@"苹果IOS",@"谷歌android",@"微软",@"微软WP",@"table",@"table",@"table",@"六六",@"六六",@"六六",@"table",@"table",@"table"]mutableCopy];
}

- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController].navigationController popToRootViewControllerAnimated:YES];
}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        return dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = dataArray[indexPath.row];
    }
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
    NSLog(@">>>>>>>>searchBar.text>>>>>>%@",searchBar.text);
    SearchDetailController *sdc = [[SearchDetailController alloc] initWithUrl:[NSString stringWithFormat:@"http://www.spyg.com.cn/app/search.php?encode=%@",[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] title:@""];
    [self.navigationController pushViewController:sdc animated:YES];

}


#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    searchResults = [[NSMutableArray alloc]init];
//    if (mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
//        for (int i=0; i<dataArray.count; i++) {
//            if ([ChineseInclude isIncludeChineseInString:dataArray[i]]) {
//                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
//                NSRange titleResult=[tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
//                if (titleResult.length>0) {
//                    [searchResults addObject:dataArray[i]];
//                }
//                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
//                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
//                if (titleHeadResult.length>0) {
//                    [searchResults addObject:dataArray[i]];
//                }
//            }
//            else {
//                NSRange titleResult=[dataArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
//                if (titleResult.length>0) {
//                    [searchResults addObject:dataArray[i]];
//                }
//            }
//        }
//    } else if (mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
//        for (NSString *tempStr in dataArray) {
//            NSRange titleResult=[tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
//            if (titleResult.length>0) {
//                [searchResults addObject:tempStr];
//            }
//        }
//    }
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    [UIView animateWithDuration:0.7 animations:^{
//        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    } completion:^(BOOL finished) {
//        ;
//    }];
//}
@end
