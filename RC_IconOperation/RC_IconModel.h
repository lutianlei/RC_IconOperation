//
//  RC_IconModel.h
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//
//
//
//  ************** 运输兵
//
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RC_IconModel : NSObject

@property (copy, nonatomic, readonly) NSString *imageUrl;
@property (copy, nonatomic, readonly) NSString *tb_title;

@property (nonatomic, copy) NSString *fileName;                        // 本地文件名字
@property (nonatomic, copy) NSString *pathDisk;                        // 文件绝对路径


+ (RC_IconModel *)data:(NSDictionary *)dataInfo;

+ (NSArray <RC_IconModel *>*)modelArrayFromArray:(NSArray *)array;

- (UIImage *)tb_image;

- (void)startDownloadImage;
@end
