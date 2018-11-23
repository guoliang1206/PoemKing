//
//  BackupFileListCell.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/6.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqliteFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface BackupFileListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *recoverButton;

- (void)setCellWithModel:(SqliteFile *)model;

@end

NS_ASSUME_NONNULL_END
