//
//  RC_IconOperationService.m
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_IconOperationService.h"
#import "RC_IconModelOperator.h"

@interface RC_IconOperationService ()

@property (strong , nonatomic , readwrite) NSArray *tabBarIcon_list;


@end

@implementation RC_IconOperationService

+ (RC_IconOperationService *)service{
    return [RC_IconOperationService instance];
}

+ (instancetype)instance{
    
    static RC_IconOperationService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[RC_IconOperationService alloc] init];
    });
    return service;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


- (void)startOperationService:(NSString *)urlString block:(RC_IconOperationServiceBlock)block{
    [[RC_IconModelOperator modelOperator] setTarbarURL:urlString];
    [[RC_IconOperationService service] checkOperationInfo];
    if (block) {
        block([RC_IconOperationService service].tabBarIcon_list);
    }
}

- (void)checkOperationInfo{
    if ([self needShowOperation]) {
        self.tabBarIcon_list = [self needShowOperation];
    }
}

- (NSArray *)needShowOperation{
    return [[RC_IconModelOperator modelOperator] isNeedReplaceIcon];
}

@end
