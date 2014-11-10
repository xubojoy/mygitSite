//
//  NetProcessor.h
//  IMFiveApp
//
//  Created by myStyle on 14-11-10.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetProcessor : NSObject
@property (nonatomic, strong) Reachability *reachability;

-(void) initNet;
-(void)reachabilityChanged:(NSNotification *) note;
@end
