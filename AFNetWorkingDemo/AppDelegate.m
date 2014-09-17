//
//  AppDelegate.m
//  AFNetWorkingDemo
//
//  Created by Marshal Wu on 14-9-16.
//  Copyright (c) 2014年 Marshal Wu. All rights reserved.
//

#import "AppDelegate.h"
#import <AFHTTPSessionManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
}


@end
