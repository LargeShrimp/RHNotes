//
//  NoteEntity.m
//  RHNotes
//
//  Created by taitanxiami on 16/9/4.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "NoteEntity.h"

@implementation NoteEntity

//--MTLJSONSerializing Delegate
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"content":@"content",
             @"creatAt":@"creatAt",
             @"lastModifyDate":@"lastModifyAt",
             @"star":@"star",
             @"noteIdx":@"index_id",
             @"noteId":@"id"
             };

}

//--MTLFMDBSerializing Delegate
+ (NSDictionary *)FMDBColumnsByPropertyKey {
    
    return @{
             @"content":@"content",
             @"creatAt":@"creatAt",
             @"lastModifyDate":@"lastModifyAt",
             @"star":@"star",
             @"noteIdx":@"index_id",
             @"noteId":@"id"
             };
}

+ (NSArray *)FMDBPrimaryKeys {
    return @[@"id"];
}

+ (NSString *)FMDBTableName {
    return @"notes";
}
@end
