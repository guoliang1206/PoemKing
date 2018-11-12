//
//  LGUtils.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/12.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGUtils : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;

+(NSString *)getIpAddresses1;

@end

NS_ASSUME_NONNULL_END
