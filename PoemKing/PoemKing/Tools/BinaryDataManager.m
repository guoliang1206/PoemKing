//
//  BinaryDataManager.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/2.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "BinaryDataManager.h"

@implementation BinaryDataManager


+ (instancetype)sharedBinDataManager{
    
    static BinaryDataManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[BinaryDataManager alloc]init];
    });
    return manager;
}

-(NSArray*)getRemarkDataBy:(NSData *)data{
    Byte *testByte = (Byte *)[data bytes];
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    int len = 0;
    int index = 0;
    while (true) {
        index++;
        len = testByte[index];
        index++;
        
        if (index + len > [data length]) {
            break;
        }
        
        NSString* str = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(index, len)] encoding:NSUTF8StringEncoding];
        if (str != nil) {
            [arr addObject:str];
        }
        
        index += len;
    }
    
    return [arr copy];
}


-(NSString *)getPhotoBy:(NSData *)data{
    if (data.length <= 8) {
        return @"";
    }
    
    int begin = 0;
    int end = 0;
    
    Byte *byteData = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++){
        if (byteData[i] == 104 && begin == 0) {//104 = "h"
            begin = i;
        }
        
        if (byteData[i] == 26 && end == 0) {//26 = "结束"
            end = i;
        }
    }
    
    if (begin > 0 && end > 0) {
        int len = end - begin;
        NSData* tempData = [data subdataWithRange:NSMakeRange(begin, len)];
        NSString* str = [[NSString alloc]initWithData:tempData encoding:NSASCIIStringEncoding];
        
        return str;
    }
    
    return @"";
}

@end
