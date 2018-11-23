//
//  FriendsCell.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/22.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXFriends.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendsCell : UITableViewCell

- (void)setCellWithModule:(WXFriends *)model;

@end

NS_ASSUME_NONNULL_END
