//
//  WXFriends.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/21.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXFriends : NSObject

@property (strong, nonatomic) NSString *wxid;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *headImage;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *region;


@end

NS_ASSUME_NONNULL_END
