//
//  SqliteManager.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/2.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager : NSObject

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, copy) NSString *dbPath;

+ (instancetype)sharedSqliteManager;

- (BOOL)openDBWithDBPath:(NSString *)dbPath;
- (NSMutableArray* )queryWithSql:(NSString *)sql;



@end

NS_ASSUME_NONNULL_END
