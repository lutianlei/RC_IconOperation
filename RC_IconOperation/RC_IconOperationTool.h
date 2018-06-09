//
//  RC_IconOperationTool.h
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//
//
//
//  ************** 保障兵
//
//
//


#import <Foundation/Foundation.h>

@interface RC_IconOperationTool : NSObject

/**创建TabBar图文件夹*/
+(NSString *)getTBImageFolderPath;

/**获取TB信息plist文件路径*/
+ (NSString *)getTBInfoPath;

/**把一个文件拷贝到另一个目录中*/
+ (BOOL)copyFileWithFilePath:(NSString *)filePath newFileName:(NSString *)newFileName;

/**删除某个文件*/
+ (BOOL)removeFileWithPath:(NSString *)path;

@end
