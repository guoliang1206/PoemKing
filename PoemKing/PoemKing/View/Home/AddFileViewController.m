//
//  AddFileViewController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/5.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "AddFileViewController.h"
#import "Masonry.h"

@interface AddFileViewController ()

@end

@implementation AddFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加文件";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialPage];
}

- (void)initialPage{
    
    UIView *selfAddView = [UIView new];
    UIView *artificialServiceView = [UIView new];
    
    
    [self.view addSubview:selfAddView];
    [self.view addSubview:artificialServiceView];
    
    selfAddView.backgroundColor = [UIColor purpleColor];
    artificialServiceView.backgroundColor = [UIColor redColor];
    
    [selfAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(-90);
        make.height.mas_equalTo(80);
    }];
    
    [artificialServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(10);
        make.height.mas_equalTo(80);
    }];
}



@end
