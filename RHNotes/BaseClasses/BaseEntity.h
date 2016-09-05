//
//  BaseEntity.h
//  FMDBWithMantle
//
//  Created by taitanxiami on 16/9/3.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseEntity : MTLModel<MTLJSONSerializing>
+ (id)entityFromDictionary:(NSDictionary *)data;
@end
