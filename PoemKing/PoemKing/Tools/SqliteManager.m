//
//  SqliteManager.m
//  PoemKing
//
//  Created by Leon Guo on 2018/11/2.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "SqliteManager.h"
#import "WXContacts.h"

@implementation SqliteManager

+ (instancetype)sharedSqliteManager{
    
    static SqliteManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[SqliteManager alloc] init];
    });
    
    return manager;
}

- (BOOL)openDBWithDBPath:(NSString *)dbPath{
    
    self.dbPath = dbPath;
    self.db = [FMDatabase databaseWithPath:dbPath];
    return [self.db open];
}

- (NSMutableArray* )queryWithSql:(NSString *)sql{
    
    NSMutableArray * result = [NSMutableArray arrayWithCapacity:0];
    
    FMResultSet *resultSet = [self.db executeQuery:sql];
    
    while ([resultSet next]) {
        WXContacts *contact = [[WXContacts alloc] init];
        contact.userName = [resultSet stringForColumn:@"userName"];
        contact.dbContactHeadImage = [resultSet dataForColumn:@"dbContactHeadImage"];
        contact.dbContactRemark = [resultSet dataForColumn:@"dbContactRemark"];
        contact.dbContactLocal = [resultSet dataForColumn:@"dbContactLocal"];
        contact.dbContactProfile = [resultSet dataForColumn:@"dbContactProfile"];
        contact.dbContactSocial = [resultSet dataForColumn:@"dbContactSocial"];
        contact.dbContactOther = [resultSet dataForColumn:@"dbContactOther"];
        contact.dbContactBrand = [resultSet dataForColumn:@"dbContactBrand"];
        contact.dbContactChatRoom = [resultSet dataForColumn:@"dbContactChatRoom"];
        contact.type = [resultSet intForColumn:@"type"];
        [result addObject:contact];
    
    }
    
    return result;
}

@end
