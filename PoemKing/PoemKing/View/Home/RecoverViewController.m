//
//  RecoverViewController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/5.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "RecoverViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "Masonry.h"
#import "AddFileViewController.h"
#import "BackupFileListCell.h"


@interface RecoverViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation RecoverViewController

-(NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"文件列表";
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"BackupFileListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BackupFileListCell"];
    [self.dataSource addObject:@"TestUser"];
    
    [self.tableview reloadData];
    
}


//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//
//    return [UIImage imageNamed:@""];
//}


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIView * bgview = [[UIView alloc] init];
    [self.tableview addSubview:bgview];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableview).with.insets(padding);
    }];
  
    UIImage *emptyImage = [UIImage imageNamed:@"emptyData.png"];
    UIImageView *emptyDataImageView = [[UIImageView alloc] initWithImage:emptyImage];
    [bgview addSubview:emptyDataImageView];
    
    [emptyDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgview.mas_centerX);
        make.top.mas_equalTo(bgview.mas_top).mas_offset(64);
        make.width.mas_equalTo(bgview.mas_width).mas_offset(-30);
        make.height.equalTo(emptyDataImageView.mas_width);
    }];
    
    NSString *text = @"点击添加备份文件";
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
    UILabel *tipLable = [[UILabel alloc] init];
    [tipLable setAttributedText:title];
    [bgview addSubview:tipLable];
    
    
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyDataImageView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(bgview.mas_centerX);
        make.height.mas_equalTo(30);
        
    }];
    
    
    return bgview;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.navigationController pushViewController:[AddFileViewController new] animated:YES];
    NSLog(@"View Taped !!!");
}


#pragma - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BackupFileListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BackupFileListCell" forIndexPath:indexPath];
    
    return cell;
}


@end
