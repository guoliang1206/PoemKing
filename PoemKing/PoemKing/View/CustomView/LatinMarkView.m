//
//  LatinMarkView.m
//  PoemKing
//
//  Created by Leon Guo on 2018/10/11.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "LatinMarkView.h"

@implementation LatinMarkView

- (instancetype) initWithContent:(NSString *)conetent mark:(NSString *)mark{
    self = [super init];
    if(self){
        [self setFrame:CGRectMake(0, 0, 200, 200)];
        self.backgroundColor = [UIColor colorWithDisplayP3Red:0.3 green:0.4 blue:0.5 alpha:1];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
