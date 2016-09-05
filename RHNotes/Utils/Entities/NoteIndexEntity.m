//
//  NoteIndexEntity.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "NoteIndexEntity.h"

@implementation NoteIndexEntity
//--MTLJSONSerializing Delegate
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"name":@"name",
             @"noteIdxId":@"id",
             @"notesCount":@"notesCount"
             };
    
}

//--MTLFMDBSerializing Delegate
+ (NSDictionary *)FMDBColumnsByPropertyKey {
    
    return @{
             @"name":@"name",
             @"noteIdxId":@"id",
             @"notesCount":@"notesCount"
             };}

+ (NSArray *)FMDBPrimaryKeys {
    return @[@"id"];
}

+ (NSString *)FMDBTableName {
    return @"notesIndex";
}

@end
