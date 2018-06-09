//
//  RC_IconModel.m
//  RC_IconOperationDemo
//
//  Created by lutianlei on 2018/6/7.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "RC_IconModel.h"
#import "RC_IconOperationNetwork.h"
#import "RC_IconOperationTool.h"

@interface RC_IconModel ()

@property (copy, nonatomic, readwrite) NSString *imageUrl;
@property (copy, nonatomic, readwrite) NSString *tb_title;



@end

@implementation RC_IconModel

+ (RC_IconModel *)data:(NSDictionary *)dataInfo{
    
    RC_IconModel *model = [[RC_IconModel alloc] init];
    model.imageUrl = dataInfo[@"imageUrl"];
    model.tb_title = dataInfo[@"tb_title"];
    
    return model;
}

+ (NSArray<RC_IconModel *> *)modelArrayFromArray:(NSArray *)array{
    
    NSMutableArray *mutaArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [mutaArr addObject:[RC_IconModel data:dic]];
    }
    return [NSArray arrayWithArray:mutaArr];
}

- (UIImage *)tb_image{
    
    UIImage *image = [UIImage imageWithContentsOfFile:self.pathDisk];
    
    return image;

}

- (NSString *)fileName{
    if (!_fileName && _imageUrl) {
        _fileName = [NSURL URLWithString:_imageUrl].lastPathComponent;
    }
    return _fileName;
}

- (NSString *)pathDisk{
    if (!_pathDisk) {
        _pathDisk = [[RC_IconOperationTool getTBImageFolderPath] stringByAppendingPathComponent:self.fileName];
    }
    return _pathDisk;
}

- (void)startDownloadImage{
    
    [RC_IconOperationNetwork downLoadImageWithURL:self.imageUrl
                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                    if (error == nil) {
                                        //保存图片
                                        
                                        NSString *locationPath = [NSString stringWithFormat:@"%s", location.fileSystemRepresentation];
                                        NSLog(@"下载图片的路径...%@", locationPath);
                                        
                                        // 把下载到临时文件目录中的图片保存到，图片目录中
                                        [RC_IconOperationTool copyFileWithFilePath:locationPath newFileName:[self fileName]];
                                    }
                                }];
    
}


@end
