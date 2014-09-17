//
//  AppDelegate.m
//  AFNetWorkingDemo
//
//  Created by Marshal Wu on 14-9-16.
//  Copyright (c) 2014年 Marshal Wu. All rights reserved.
//

#import <AFHTTPSessionManager.h>

#import "AppDelegate.h"
#import "HttpMock.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [HttpMock initMock];
    return YES;
}


@end
