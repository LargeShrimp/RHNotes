//
//  BaseEntity.m
//  FMDBWithMantle
//
//  Created by taitanxiami on 16/9/3.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

+ (id)entityFromDictionary:(NSDictionary *)data {
    NSError *error;
    id entity = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:data error:&error];
    
    if (error) {
        NSLog(@"Couldn't convert JSON to Entity: %@", error);
        return nil;
    }
    return entity;
}

//实现代理方法
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSLog(@"You must override %@ in a subclass",NSStringFromSelector(_cmd));
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
@end
