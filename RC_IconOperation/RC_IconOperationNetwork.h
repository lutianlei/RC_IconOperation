//
//  RC_IconOperationNetwork.h
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//
//
//  ************** 网警
//
//
//
#import <Foundation/Foundation.h>



@interface RC_IconOperationNetwork : NSObject

// 下载图片文件
+ (void)downLoadImageWithURL:(NSString *)imgURL
           completionHandler:(void (^)(NSURL *location, NSURLResponse *response, NSError *error))completionHandler;

+ (void)downLoadConfigurationPlistWithURL:(NSString *)urlString
                        completionHandler:(void (^)(NSArray *dataList, NSURLResponse *response, NSError *error))completionHandler;
@end
