//
//  RC_IconOperationTool.m
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_IconOperationTool.h"

static NSString *const kOperationTBimageFolderPath = @"tabbar_image";           // TabBar图片文件夹
static NSString *const kOperationTBInfoPath = @"tb_infos";                      // TabBar图片信息


@implementation RC_IconOperationTool


/**创建TabBar图文件夹*/
+(NSString *)getTBImageFolderPath {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *tbImageFold = [docPath stringByAppendingPathComponent:kOperationTBimageFolderPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:tbImageFold]) {
        
        BOOL suss = [[NSFileManager defaultManager] createDirectoryAtPath:tbImageFold
                                              withIntermediateDirectories:YES
                                                               attributes:nil
                                                                    error:nil];
        if (!suss) {
            NSLog(@"创建TabBar图片目录失败！");
        }
    }
    
    return tbImageFold;
}

/**获取TB信息plist文件路径*/
+ (NSString *)getTBInfoPath{
    
    return [[RC_IconOperationTool getTBImageFolderPath] stringByAppendingPathComponent:kOperationTBInfoPath];
}

+ (BOOL)copyFileWithFilePath:(NSString *)filePath newFileName:(NSString *)newFileName{
    return [RC_IconOperationTool copyFileWithFilePath:filePath toOtherfolderPath:[RC_IconOperationTool getTBImageFolderPath] newFileName:newFileName];
}

/**把一个文件拷贝到另一个目录中*/
+ (BOOL)copyFileWithFilePath:(NSString *)filePath toOtherfolderPath:(NSString *)folderPath newFileName:(NSString *)newFileName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL hasFilePath = [fileManager fileExistsAtPath:filePath];
    
    BOOL isDirectory = YES;
    BOOL hasFolderPath = [fileManager fileExistsAtPath:folderPath isDirectory:&isDirectory];
    
    if (hasFilePath & hasFolderPath) {
        
        // 创建目标文件路径
        NSString *dstPath = [folderPath stringByAppendingPathComponent:newFileName];
        
        NSError *error = nil;
        [fileManager moveItemAtPath:filePath toPath:dstPath error:&error];
        
        if (error) {
            
            NSLog(@"移动文件错误: %@", error);
            
            return NO;
        }else {
            
            return YES;
        }
    }
    
    if (!hasFilePath) {
        
        NSLog(@"moveFileToOtherFolder: 没有文件");
    }
    
    if (!hasFolderPath) {
        
        NSLog(@"moveFileToOtherFolder: 没有目录");
    }
    
    return NO;
    
}


/**删除某个文件*/
+ (BOOL)removeFileWithPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]){
        
        NSError *error = nil;
        
        [fileManager removeItemAtPath:path error:&error];
        
        if (error) {
            NSLog(@"删除文件出错%@",error);
        }else{
            return YES;
        }
    }
    return NO;
}

@end
