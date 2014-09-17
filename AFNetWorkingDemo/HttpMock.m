//
//  HttpMock.m
//  AFNetWorkingDemo
//
//  Created by Marshal Wu on 14-9-17.
//  Copyright (c) 2014年 Marshal Wu. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>

#import "HttpMock.h"
#import "OCFURLQuery.h"

@implementation HttpMock

+ (void) initMock
{
    NSString *baseUrl=@"http://localhost";
    
    //针对http://locahost/json请求的mock
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
//        return [[request.URL absoluteString] isEqualToString:[NSString stringWithFormat:@"%@/json",baseUrl]];
        
        NSDictionary *params=[NSDictionary objectsFromURLQueryString:request.URL.query];
        NSLog(@"id: %@",params[@"id"]);
        
        return [[request.URL absoluteString] rangeOfString:[NSString stringWithFormat:@"%@/json",baseUrl]].location==0;
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSLog(@"reqeust: %@",request);
        NSString* fixture = OHPathForFileInBundle(@"test.json",nil);
        return [[OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                 statusCode:200 headers:@{@"Content-Type":@"text/json"}
                 ]requestTime:0 responseTime:0];
    }];
    
    //GET image with sdwebimage
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [[request.URL absoluteString] isEqualToString:@"http://www.sogou.com/images/logo/new/sogou.png"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSLog(@"reqeust: %@",request);
        NSString* fixture = OHPathForFileInBundle(@"taobao.png",nil);
        return [[OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                 statusCode:200 headers:@{@"Content-Type":@"image/png"}
                 ]requestTime:0 responseTime:0];
    }];
    
    //GET image with afnetworking
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [[request.URL absoluteString] isEqualToString:@"http://www.baidu.com/img/bdlogo.png"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSLog(@"reqeust: %@",request);
        NSString* fixture = OHPathForFileInBundle(@"yklogo.png",nil);
        return [[OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                 statusCode:200 headers:@{@"Content-Type":@"image/png"}
                 ]requestTime:0 responseTime:0];
    }];
    
}

@end
