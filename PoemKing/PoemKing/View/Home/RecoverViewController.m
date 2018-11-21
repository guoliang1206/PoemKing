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
#import "SqliteFile.h"


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
    
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserver:self selector:@selector(receiveNotification:) name:@"sqlFileAdded" object:nil];
    
    [self loadDataFromSandBox];
    
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
    SqliteFile * sqlModel = [self.dataSource objectAtIndex:indexPath.row];
    [cell setCellWithModel:sqlModel];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定删除该条数据？" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        
            SqliteFile *fileNeedDelete = self.dataSource[indexPath.row];
            //delete file data in sandbox
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if([fileManager fileExistsAtPath:fileNeedDelete.filePath]){
                [fileManager removeItemAtPath:fileNeedDelete.filePath error:nil];
            }
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (void)loadDataFromSandBox{
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil] pathsMatchingExtensions:@[@"sqlite"]];
    
    for (int i = 0; i < fileList.count; i++) {
        SqliteFile *sqliteFile = [[SqliteFile alloc] init];
        sqliteFile.fileName = fileList[i];
        [self.dataSource addObject:sqliteFile];
    }
    
    //can't reload data here, caused UI API called on a background thread
    [self.tableview reloadData];
}

#pragma Notification callback

- (void)receiveNotification:(NSNotification *)notiy{
    // if the sql file has uploaded and saved, read the file and reload the datasource
    if([notiy.name isEqualToString: @"sqlFileAdded"]){
        [self loadDataFromSandBox];
    }
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
