//
//  NetProcessor.m
//  IMFiveApp
//
//  Created by myStyle on 14-11-10.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "NetProcessor.h"

@implementation NetProcessor
-(void) initNet{
    //注册联网状态的通知监听器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object: nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reachability startNotifier];
}

-(void)reachabilityChanged:(NSNotification *) note{
    Reachability *curReachability = [note object];
    NetworkStatus status = [curReachability currentReachabilityStatus];
    if (status == NotReachable) {
        NSLog(@"网络不通");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                message:@"网络不通,请检查网络！"
                                                  delegate:nil
                                          cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];;
    }else if(status == ReachableViaWiFi){
        NSLog(@"WIFI联网");
    }else if(status == ReachableViaWWAN){
        NSLog(@"3G/GPRS联网");
    }
 
}

@end
