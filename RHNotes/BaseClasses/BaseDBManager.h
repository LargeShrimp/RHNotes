//
//  BaseDBManager.h
//  FMDBWithMantle
//
//  Created by taitanxiami on 16/9/3.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <Mantle.h>
#import <FMDBMigrationManager.h>
#import <FMDatabaseAdditions.h>
#import <MTLFMDBAdapter/MTLFMDBAdapter.h>
#define DefaultDatabaseFileName @"MainDataBase.sqlite"
@interface BaseDBManager : NSObject

@property (strong, nonatomic) FMDatabase *db;

+ (instancetype)shareInstance;


+ (NSArray *)queryAllDataWithClass:(Class)objectClass;
//插入操作
+ (void)insertOnDuplicateUpdate:(MTLModel<MTLFMDBSerializing> *)entity;

//数据是否存在
+ (BOOL)isExists:(MTLModel<MTLFMDBSerializing> *)model;

//得到key 和value
+ (NSArray *)columnValuesForUpdate:(MTLModel<MTLFMDBSerializing> *)model;

//数据count
+ (NSNumber *)getDataCount:(Class)objectClass;

//通过id 和 类名查询
+ (id)findById:(NSString *)primary_id withClass:(Class)objectClass;
//通过model 查询
+ (id)findUsingPrimaryKeys:(MTLModel<MTLFMDBSerializing> *)model;


//通过model 删除

+ (BOOL)deleteUsingPrimaryKeys:(MTLModel<MTLFMDBSerializing> *)model;

//通过key 和 条件 查询
+ (NSArray *)findByColumn:(NSString *)column columnValue:(NSString *)value withClass:(Class)objectClass;

+ (NSArray *)findRandomByDictionary:(NSDictionary *)columnDictionary withClass:(Class)objectClass;
//多值更新

+ (id)updateDate:(NSDictionary *)columnDictionary withClass:(Class)objectClass;
+ (NSNumber *)getMaxColumnIdWithClass:(Class)objectClass column:(NSString *)column;

@end
