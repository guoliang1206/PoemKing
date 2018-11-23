//
//  FriendsViewController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/22.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "FriendsViewController.h"
#import "SqliteManager.h"
#import "WXFriends.h"
#import "WXContacts.h"
#import "BinaryDataManager.h"
#import "FriendsCell.h"

@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation FriendsViewController

- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"好友列表";
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsCell"];
    self.tableView.estimatedRowHeight = 100;
    
    [self parseSqliteFile];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WXFriends *model = [self.dataSource objectAtIndex:indexPath.row];
    
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellWithModule:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (void)parseSqliteFile{
    
    SqliteManager *manager = [SqliteManager sharedSqliteManager];
    BinaryDataManager *binDataManager = [BinaryDataManager sharedBinDataManager];
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath =  [dirPath stringByAppendingPathComponent:self.sqlFile.fileName];
    
    if([manager openDBWithDBPath:dbPath]){
        
        NSMutableArray *contacts = [manager queryWithSql:@"select * from Friend where type = '3' or type = '7';"];
        for (WXContacts *contact in contacts) {
            
            WXFriends *friend = [WXFriends new];
            friend.headImage = [binDataManager getPhotoBy:contact.dbContactHeadImage];
            friend.wxid = contact.userName;
            friend.nickName = [[binDataManager getRemarkDataBy:contact.dbContactRemark].firstObject stringByRemovingPercentEncoding];
            [self.dataSource addObject:friend];
            
            
            NSLog(@"UserName : %@ , remark : %@ , headImage: %@",contact.userName,[[binDataManager getRemarkDataBy:contact.dbContactRemark].firstObject stringByRemovingPercentEncoding],[binDataManager getPhotoBy:contact.dbContactHeadImage]);
            NSLog(@"dbContactLocal :%@",[[NSString alloc]initWithData:contact.dbContactLocal encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactOther :%@",[[NSString alloc]initWithData:contact.dbContactOther encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactProfile :%@",[[NSString alloc]initWithData:contact.dbContactProfile encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactSocial :%@",[[NSString alloc]initWithData:contact.dbContactSocial encoding:NSUTF8StringEncoding]);
            
        }
        
        [self.tableView reloadData];
    }
}


- (void)parseContactProfile:(NSString *)profile{
    
}

@end
