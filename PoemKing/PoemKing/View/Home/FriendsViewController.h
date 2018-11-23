//
//  FriendsViewController.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/22.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqliteFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendsViewController : UIViewController

@property (strong, nonatomic) SqliteFile *sqlFile;

@end

NS_ASSUME_NONNULL_END
