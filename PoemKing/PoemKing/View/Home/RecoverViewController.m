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

@interface RecoverViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation RecoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"文件列表";
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;
    self.tableview.tableFooterView = [UIView new];
    
   
    
}


//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//
//    return [UIImage imageNamed:@""];
//}


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIView * bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor purpleColor];
    [self.tableview addSubview:bgview];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableview).with.insets(padding);
    }];
  
    
    NSString *text = @"请添加备份文件";

    NSDictionary * attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
    UILabel *titleLable = [[UILabel alloc] init];
    [titleLable setAttributedText:title];
    [bgview addSubview:titleLable];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgview).width.insets(padding);
    }];
    
    
    return bgview;
}


#pragma - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecoverFileCell" forIndexPath:indexPath];
    return cell;
}


@end
