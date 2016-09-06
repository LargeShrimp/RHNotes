//
//  BaseDBManager.m
//  FMDBWithMantle
//
//  Created by taitanxiami on 16/9/3.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "BaseDBManager.h"

@implementation BaseDBManager

+ (instancetype)shareInstance {
    
    static BaseDBManager *_shareDBManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareDBManager = [[BaseDBManager alloc]init];
    });
    return _shareDBManager;
}

- (instancetype)init {
    
    self = [super init ];
    if (self) {
        
        BOOL reuslt = [self repareDatabase:nil];
        if(reuslt) {
            NSLog(@"Database initialization successfully!");
        }else {
            NSLog(@"Database initialization failed!");
        }
    }
    return self;
}

- (BOOL)repareDatabase:(NSError * __autoreleasing *)error {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths.firstObject;
    //拼接路径
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:DefaultDatabaseFileName];
    
    self.db = [FMDatabase databaseWithPath:filePath];
    
    [self.db open];
    
//    // Get migration path
//    NSBundle *parentBundle = [NSBundle bundleForClass:[BaseDBManager class]];
////    NSBundle *migrationBundle = [NSBundle bundleWithPath:[parentBundle pathForResource:@"Migrations" ofType:@"bundle"]];
//    NSBundle *migrationBundle = [NSBundle bundleWithPath:<#(nonnull NSString *)#>]
//    // Create schema_migrations Table, prepare for migrate the database
//    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabase:self.db migrationsBundle:migrationBundle];
//    if (! [manager hasMigrationsTable]) {
//        if (! [manager createMigrationsTable:error]) {
//            return NO;
//        }
//    }
//    
//    // Migrate the database if needed
//    if ([manager needsMigration]) {
//        if (! [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:error]) {
//            return NO;
//        }
//    }
    
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabaseAtPath:filePath  migrationsBundle:[NSBundle mainBundle]];
    BOOL resultState = NO;
    //创建迁移表
    if (!manager.hasMigrationsTable) {
        resultState = [manager createMigrationsTable:error];
        if (!resultState) {
            return  NO;
        }
    }
    //把数据库迁移到最大版本
    resultState = [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:error];    
    if (!resultState) {
        return NO;
    }
    NSLog(@"Has `schema_migrations` table?: %@", manager.hasMigrationsTable ? @"YES" : @"NO");
    NSLog(@"Origin Version: %llu", manager.originVersion);
    NSLog(@"Current version: %llu", manager.currentVersion);
    NSLog(@"All migrations: %@", manager.migrations);
    NSLog(@"Applied versions: %@", manager.appliedVersions);
    NSLog(@"Pending versions: %@", manager.pendingVersions);
    return YES;
}


#pragma mark - Public Functions

+ (NSArray *)queryAllDataWithClass:(Class)objectClass {
    
    NSError *error = nil;
    NSString * query = [NSString stringWithFormat:@"select * from %@",[objectClass FMDBTableName]];
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query];
    NSMutableArray *result = [NSMutableArray array];
    //把 resultSet 转换成model
    while  ([resultSet next]) {
        [result addObject:[MTLFMDBAdapter modelOfClass:objectClass fromFMResultSet:resultSet error:&error]];
    }
    return result;

}
+ (NSArray *)columnValuesForUpdate:(MTLModel<MTLFMDBSerializing> *)model {
    
    NSArray *columnValues = [MTLFMDBAdapter columnValues:model];
    NSArray *keysValues = [MTLFMDBAdapter primaryKeysValues:model];
    
    NSMutableArray *params = [NSMutableArray array];
    [params addObjectsFromArray:columnValues];
    [params addObjectsFromArray:keysValues];
    
    return params;
}

+ (BOOL)isExists:(MTLModel<MTLFMDBSerializing> *)model {
    if (!model) return NO;
    
    BOOL isExists = NO;
    NSString * query = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@ WHERE %@", [model.class FMDBTableName],  [MTLFMDBAdapter whereStatementForModel:model]];
    NSArray *params = [MTLFMDBAdapter primaryKeysValues:model];
    //查询操作
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query withArgumentsInArray:params];
    if  ([resultSet next]) {
        NSNumber *count = [resultSet objectForColumnName:@"count"];
        NSLog(@"Count ---> %@", count);
        isExists = ([count intValue] > 0) ? YES : NO;
    }
    
    return isExists;
}

+ (void)insertOnDuplicateUpdate:(MTLModel<MTLFMDBSerializing> *)entity {
    if (!entity) return;
    
    if ([self.class isExists:entity])
    {
        NSString *stmt = [MTLFMDBAdapter updateStatementForModel:entity];
        NSArray *params = [self.class columnValuesForUpdate:entity];
        //更新操作
        [[BaseDBManager shareInstance].db executeUpdate:stmt withArgumentsInArray:params];
    }
    else
    {
        NSString *stmt = [MTLFMDBAdapter insertStatementForModel:entity];
        NSArray *params = [MTLFMDBAdapter columnValues:entity];
        
        [[BaseDBManager shareInstance].db executeUpdate:stmt withArgumentsInArray:params];
    }
}
+ (NSNumber *)getDataCount:(Class)objectClass {
    NSNumber *count = 0;
    
    NSString * query = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@", [objectClass FMDBTableName]];
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query];
    
    if  ([resultSet next]) {
        count = [resultSet objectForColumnName:@"count"];
        NSLog(@"Count ---> %@", count);
    }
    
    return count;
}
+ (id)findUsingPrimaryKeys:(MTLModel<MTLFMDBSerializing> *)model{
    
    NSError *error = nil;
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", [[model class] FMDBTableName],[MTLFMDBAdapter whereStatementForModel:model]];
    
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query];
    while ([resultSet next]) {
        return [MTLFMDBAdapter modelOfClass:[model class] fromFMResultSet:resultSet error:&error];
    }
    return nil;
}

+ (id)findById:(NSString *)primary_id withClass:(Class)objectClass; {
    if (!primary_id) return nil;
    NSError *error = nil;
    NSString *query = [NSString stringWithFormat:@"select * from %@ where id=%@", [objectClass FMDBTableName], primary_id];
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query];
    if ([resultSet next]) {
        return [MTLFMDBAdapter modelOfClass:objectClass fromFMResultSet:resultSet error:&error];
    }
    return nil;
}

+ (NSArray *)findByColumn:(NSString *)column columnValue:(NSString *)value withClass:(Class)objectClass {
    if (!column || !value) return nil;
    NSError *error = nil;
    NSString * query = [NSString stringWithFormat:@"select * from %@ where %@='%@'", [objectClass FMDBTableName], column, value];
    FMResultSet *resultSet = [[BaseDBManager shareInstance].db executeQuery:query];
    NSMutableArray *result = [NSMutableArray array];
    //把 resultSet 转换成model
    while  ([resultSet next]) {
        [result addObject:[MTLFMDBAdapter modelOfClass:objectClass fromFMResultSet:resultSet error:&error]];
    }
    return result;
}

+ (id)updateDate:(NSDictionary *)columnDictionary withClass:(Class)objectClass {
    if (!columnDictionary) return nil;
    
    NSMutableArray *whereArray = [NSMutableArray array];
    for (NSString *key in columnDictionary) {
        NSString *s = [NSString stringWithFormat:@"%@ = %@", key, columnDictionary[key]];
        [whereArray addObject:s];
    }
    
    NSString *whereString = [whereArray componentsJoinedByString:@" , "];
    
    NSString *query = [NSString stringWithFormat:@"update %@ set %@", [objectClass FMDBTableName], whereString];
    NSLog(@"update query is %@", query);
    BOOL resultSet = [[BaseDBManager shareInstance].db executeUpdate:query];
    if (resultSet == NO) {
        NSLog(@"error is %@", [[BaseDBManager shareInstance].db lastErrorMessage]);
    }
    return nil;
}
+ (BOOL)deleteUsingPrimaryKeys:(MTLModel<MTLFMDBSerializing> *)model {
    NSString * query = [NSString stringWithFormat:@"delete  from %@ where %@", [[model class] FMDBTableName],[MTLFMDBAdapter whereStatementForModel:model]];
    NSArray *paramas = [MTLFMDBAdapter primaryKeysValues:model];
    BOOL resultSet = [[BaseDBManager shareInstance].db executeUpdate:query withArgumentsInArray:paramas];
    return resultSet;
    
}
- (void)dealloc {
    [self.db close];
}
@end
