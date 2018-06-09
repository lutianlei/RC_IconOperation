//
//  RC_IconModelOperator.h
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//
//
//
//  ************** 数据操盘手
//
//
//
#import <Foundation/Foundation.h>

@interface RC_IconModelOperator : NSObject

@property (class, nonatomic, readonly)RC_IconModelOperator *modelOperator;

@property (copy, nonatomic)NSString *tarbarURL;

- (NSArray *)isNeedReplaceIcon;

@end
