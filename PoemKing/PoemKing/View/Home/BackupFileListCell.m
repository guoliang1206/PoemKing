//
//  BackupFileListCell.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/6.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "BackupFileListCell.h"
@interface BackupFileListCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BackupFileListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModel:(SqliteFile *)model{
    [self.titleLabel setText:model.fileName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
