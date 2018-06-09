//
//  RC_IconModelOperator.m
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_IconModelOperator.h"
#import "RC_IconOperationNetwork.h"
#import "RC_IconOperationTool.h"
#import "RC_IconModel.h"

@interface RC_IconModelOperator ()

@end

@implementation RC_IconModelOperator

+ (RC_IconModelOperator *)modelOperator{
    return [RC_IconModelOperator install];
}

+ (instancetype)install{
    static RC_IconModelOperator *operator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operator = [[RC_IconModelOperator alloc] init];
    });
    return operator;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (NSArray *)isNeedReplaceIcon{
    // 检查本地是否有存储图片
    return [self getIconImageList];
}

- (void)loadSource{
    [RC_IconOperationNetwork downLoadConfigurationPlistWithURL:self.tarbarURL completionHandler:^(NSArray *dataList, NSURLResponse *response, NSError *error) {
        if (error == nil) {     // 请求成功
            
            if (dataList.count > 0) {
                
                // 做相应的保存操作
                NSString *infoPath = [RC_IconOperationTool getTBInfoPath];
                
                if ([dataList writeToFile:infoPath atomically:YES]) {
                    //保存成功下载图片
                    [self startDownloadImage];
                    
                }
                
            } else {
                // 删除数据
                [RC_IconOperationTool removeFileWithPath:[RC_IconOperationTool getTBInfoPath]];
                // 删除图片
                [self removeAllImageData];
            } 
            
        }else {      // 请求失败
            
        }
    }];
}

- (void)startDownloadImage{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[RC_IconOperationTool getTBInfoPath]];
    NSArray *models = [RC_IconModel modelArrayFromArray:plistArray];

    // 下载
    for (RC_IconModel *model in models) {
        [model startDownloadImage];
    }
}
/**获取本地存储的图片*/
- (NSArray *)getIconImageList{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[RC_IconOperationTool getTBInfoPath]];
    NSArray *models = [RC_IconModel modelArrayFromArray:plistArray];
    NSMutableArray *mutaArr = [NSMutableArray array];
    
    for (RC_IconModel *model in models) {
        [mutaArr addObject:[model tb_image]];
    }
    
    // 更新图片信息
    [self loadSource];
    
    return [NSArray arrayWithArray:mutaArr];
}

/**删除本地存储的图片*/
- (void)removeAllImageData{
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:[RC_IconOperationTool getTBInfoPath]];
    NSArray *models = [RC_IconModel modelArrayFromArray:plistArray];
    // 下载
    for (RC_IconModel *model in models) {
        BOOL isres = [RC_IconOperationTool removeFileWithPath:model.pathDisk];
        if (isres) {
            NSLog(@"图片删除成功，图片地址：%@",model.pathDisk);
        }
    }
}


@end
