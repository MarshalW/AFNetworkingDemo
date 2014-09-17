//
//  ViewController.m
//  AFNetWorkingDemo
//
//  Created by Marshal Wu on 14-9-16.
//  Copyright (c) 2014年 Marshal Wu. All rights reserved.
//

#import "ViewController.h"

#import <AFHTTPSessionManager.h>
#import <UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
{
    
    __weak IBOutlet UIImageView *imageView;
    NSURL *uploadFilePath;
}

@end

@implementation ViewController

-(void)viewDidLoad
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    NSLog(@"This is from new feature branch");
}

- (IBAction)getAndHTMLResponse:(id)sender {
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost/"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"My Browser"}];
    
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params=[[NSDictionary alloc] initWithObjectsAndKeys:@"3",@"id",nil];
    
    [manager GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"HTML: %@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"visit error: %@",error);
    }];
}

- (IBAction)getAndJSONResponse:(id)sender {
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost/"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"My Browser"}];
    
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    NSDictionary *params=[[NSDictionary alloc] initWithObjectsAndKeys:@"8",@"id",nil];
    
    [manager GET:@"/json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * object=(NSDictionary *)responseObject;
        NSLog(@"response message: %@",object[@"message"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"visit error: %@",error);
    }];
}

- (IBAction)downloadImage:(id)sender {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        uploadFilePath=filePath;
    }];
    [downloadTask resume];
    
}

- (IBAction)loadImageView:(id)sender {
    imageView.image=nil;
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.png"];
    [imageView setImageWithURL:URL];
}

- (IBAction)loadImageViewFromSDWebimage:(id)sender {
    imageView.image=nil;
    NSURL *URL = [NSURL URLWithString:@"http://www.sogou.com/images/logo/new/sogou.png"];
    [imageView sd_setImageWithURL:URL];
}

- (IBAction)uploadFile:(id)sender {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://localhost/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:uploadFilePath name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];
    
    NSLog(@"dev modified");
}

@end
