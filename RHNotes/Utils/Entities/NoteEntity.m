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
+ (NSValueTransformer *)starTransformer {
    return [NSValueTransformer  valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)creatAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateString) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)lastModifyDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateString) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
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
