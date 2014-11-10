//
//  AppDelegate.m
//  IMFiveApp
//
//  Created by chen on 14-8-20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "AppDelegate.h"

#import "SliderViewController.h"
#import "LeftViewController.h"
#import "MainTabViewController.h"
#import "GuideViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
//    //开启网络状况的监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reachabilityChanged:)
//                                                 name: kReachabilityChangedNotification
//                                               object: nil];
//    hostReach = [Reachability reachabilityWithHostName:@"www.google.com"];//可以以多种形式初始化
//    [hostReach startNotifier];  //开始监听,会启动一个run loop
//    [self updateInterfaceWithReachability: hostReach];
    //注册联网状态的通知监听器
    self.netProcessor = [NetProcessor new];
    [self.netProcessor initNet];

    
    
    
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }

    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    [SliderViewController sharedSliderController].LeftVC = leftVC;
    [SliderViewController sharedSliderController].MainVC = [[MainTabViewController alloc] init];
    [SliderViewController sharedSliderController].LeftSContentOffset=290;
    [SliderViewController sharedSliderController].LeftContentViewSContentOffset = 320;
    [SliderViewController sharedSliderController].LeftSContentScale=0.9;
    [SliderViewController sharedSliderController].LeftSJudgeOffset=160;
    [SliderViewController sharedSliderController].changeLeftView = ^(CGFloat sca, CGFloat transX)
    {
        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
        leftVC.contentView.transform = lconT;
    };

    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        GuideViewController * guivc = [[GuideViewController alloc]init];
        self.window.rootViewController = guivc;
    }else{
        
        [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
        
        UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
        self.window.rootViewController = naviC;
        
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

//// 连接改变
//- (void) reachabilityChanged: (NSNotification* )note
//{
//    Reachability* curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    [self updateInterfaceWithReachability: curReach];
//}
//
////处理连接改变后的情况
//- (void) updateInterfaceWithReachability: (Reachability*) curReach
//{
//    //对连接改变做出响应的处理动作。
//    NetworkStatus status = [curReach currentReachabilityStatus];
//    
//    if (status == NotReachable) {  //没有连接到网络就弹出提实况
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"My App Name"
//                                                        message:@"NotReachable"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//    
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
