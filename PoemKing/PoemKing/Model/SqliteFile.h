//
//  SqliteFile.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/14.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SqliteFile : NSObject

@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *filePath;
@property (assign, nonatomic) NSInteger *fileSize;
@end

NS_ASSUME_NONNULL_END
