//
//  FriendsCell.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/22.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "FriendsCell.h"
#import "UIImageView+WebCache.h"

@interface FriendsCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;

@end

@implementation FriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithModule:(WXFriends *)model{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImage]];
    self.userName.text = model.nickName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
