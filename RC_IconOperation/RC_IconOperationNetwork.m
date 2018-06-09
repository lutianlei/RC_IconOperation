//
//  RC_IconOperationNetwork.m
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_IconOperationNetwork.h"


static NSString *const kJsonResponseStatusKey = @"rs_code";
static NSInteger const kJsonResponseSucceed = 1000;

static NSString *const kDetails = @"details";



@implementation RC_IconOperationNetwork

// 下载图片文件
+ (void)downLoadImageWithURL:(NSString *)imgURL
           completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURL *URL = [NSURL URLWithString:imgURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithRequest:request
                                                                                 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                                     
                                                                                     if (completionHandler) {
                                                                                         completionHandler(location, response, error);
                                                                                     }
                                                                                 }];
    [downloadTask resume];
    
}

+ (void)downLoadConfigurationPlistWithURL:(NSString *)urlString
                        completionHandler:(void (^)(NSArray *dataList, NSURLResponse *response, NSError *error))completionHandler {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                                                                     
                                                                     // 如果网络请求成功
                                                                     if (error == nil) {
                                                                         
                                                                         NSError *hdError = nil;
                                                                         id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&hdError];
                                                                         
                                                                         if (hdError) {
                                                                             
                                                                             // 解析失败请求失败
                                                                             if (completionHandler) {
                                                                                 completionHandler(nil, response, error);
                                                                             }
                                                                         }else {
                                                                             
                                                                             NSDictionary *jsonDic = json;
                                                                             
                                                                             if ([jsonDic[kJsonResponseStatusKey] integerValue] == kJsonResponseSucceed) {
                                                                                 
                                                                                 NSArray *dataArr = jsonDic[kDetails];
                                                                                 
                                                                                 if (completionHandler) {
                                                                                     completionHandler(dataArr, response, nil);
                                                                                 }
                                                                                 
                                                                             }else {
                                                                                 
                                                                                 if (completionHandler) {
                                                                                     completionHandler(nil, response, nil);
                                                                                 }
                                                                             }
                                                                         }
                                                                     }else {
                                                                         
                                                                         // 网络请求失败
                                                                         if (completionHandler) {
                                                                             completionHandler(nil, response, error);
                                                                         }
                                                                         
                                                                     }
                                                                 }];
    [task resume];
}

@end
