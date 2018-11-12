//
//  MainTabBarController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/10/11.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "MainTabBarController.h"
#import "SqliteManager.h"
#import "BinaryDataManager.h"
#import "WXContacts.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    SqliteManager *manager = [SqliteManager sharedSqliteManager];
    BinaryDataManager *binDataManager = [BinaryDataManager sharedBinDataManager];
    
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"WCDB_Contact" ofType:@".sqlite"];

    if([manager openDBWithDBPath:dbPath]){
        NSMutableArray *contacts = [manager queryWithSql:@"select * from Friend where type = '3' or type = '7';"];
        for (WXContacts *contact in contacts) {
            NSLog(@"UserName : %@ , remark : %@ , headImage: %@",contact.userName,[[binDataManager getRemarkDataBy:contact.dbContactRemark].firstObject stringByRemovingPercentEncoding],[binDataManager getPhotoBy:contact.dbContactHeadImage]);
            NSLog(@"dbContactLocal :%@",[[NSString alloc]initWithData:contact.dbContactLocal encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactOther :%@",[[NSString alloc]initWithData:contact.dbContactOther encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactProfile :%@",[[NSString alloc]initWithData:contact.dbContactProfile encoding:NSUTF8StringEncoding]);
            NSLog(@"dbContactSocial :%@",[[NSString alloc]initWithData:contact.dbContactSocial encoding:NSUTF8StringEncoding]);
            
        }
    }
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
