//
//  HomePageViewController.m
//  IMApp
//
//  Created by chen on 14/7/20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainTabViewController.h"
#import "QHCommonUtil.h"
#import "IndexViewController.h"
#import "ClassifyViewController.h"
#import "ShoppingViewController.h"
#import "AccountViewController.h"
#import "FeedBackViewController.h"

@interface MainTabViewController ()
{
    UITabBarController *_tabC;
}

@end

@implementation MainTabViewController

static MainTabViewController *main;

+ (MainTabViewController *)getMain
{
    return main;
}

- (id)init
{
    self = [super init];
    
    main = self;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     NSLog(@"111111111111111111111111");
    
    [self addObserver];
    [self initTabbar];
    
}

-(void)initTabbar{
    _tabC = [[UITabBarController alloc] init];
    [_tabC.tabBar setBackgroundColor:[UIColor clearColor]];
    [_tabC.view setFrame:self.view.frame];
    [self.view addSubview:_tabC.view];
    
    IndexViewController *f = [[IndexViewController alloc] init];
    ClassifyViewController *contactsVC = [[ClassifyViewController alloc] init];
    ShoppingViewController *t = [[ShoppingViewController alloc] init];
    AccountViewController *avc = [[AccountViewController alloc] init];
    FeedBackViewController *fbvc = [[FeedBackViewController alloc] init];
    _tabC.viewControllers = @[f, contactsVC, t ,avc ,fbvc];
    
    [self reloadImage];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    
    [_tabC setSelectedIndex:0];


}

- (void)reloadImage
{
    [super reloadImage];
    [_tabC.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    _tabC.delegate = self;
    NSArray *ar = _tabC.viewControllers;
    NSMutableArray *arD = [NSMutableArray new];
    [ar enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
    {
        UITabBarItem *item = nil;
        switch (idx)
        {
            case 0:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"主页" image:[[UIImage imageNamed:@"index_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"index_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 1:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"分类" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"classify_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"classify_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 2:
            {
                item = [[UITabBarItem alloc]initWithTitle:@"购物" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"shopping_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"shopping_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 3:
            {
                item = [[UITabBarItem alloc] initWithTitle:@"账户" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"account_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"account_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
            case 4:
            {
                item = [[UITabBarItem alloc]initWithTitle:@"客服" image:nil tag:1];
                [item setImage:[[UIImage imageNamed:@"feed_back_item_wbg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[UIImage imageNamed:@"feed_back_item_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                break;
            }
                
        }
        viewController.tabBarItem = item;
        [arD addObject:viewController];
    }];
    _tabC.viewControllers = arD;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = tabBarController.selectedIndex;
    NSLog(@"____________________%ld",index);

    switch (index) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"刷新" object:nil];
            break;
        case 1:

            break;
        case 2:

            break;
        case 3:

            break;
        case 4:

            break;
        default:
            break;
    }
    
}


@end
