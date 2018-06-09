//
//  RC_IconOperationService.h
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//
//
//
//  ************** 外交官
//
//
//

#import <Foundation/Foundation.h>

typedef void(^RC_IconOperationServiceBlock)(NSArray *icon_list);

@interface RC_IconOperationService : NSObject

@property (class , nonatomic , readonly) RC_IconOperationService *service;

- (void)startOperationService:(NSString *)urlString block:(RC_IconOperationServiceBlock)block;

@end
