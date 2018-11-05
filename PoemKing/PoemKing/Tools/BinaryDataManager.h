//
//  BinaryDataManager.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/2.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryDataManager : NSObject

+ (instancetype)sharedBinDataManager;
-(NSArray*)getRemarkDataBy:(NSData *)data;
-(NSString *)getPhotoBy:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
