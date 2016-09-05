//
//  NoteEntity.h
//  RHNotes
//
//  Created by taitanxiami on 16/9/4.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "BaseEntity.h"
#import <MTLFMDBAdapter.h>
@interface NoteEntity : BaseEntity<MTLFMDBSerializing>

//内容
@property (strong, nonatomic) NSString *content;

//创建时间
@property (strong, nonatomic) NSString *creatAt;

//最后修改时间
@property (strong, nonatomic) NSString *lastModifyDate;

//加星
@property (assign, nonatomic, getter=isStar) BOOL star;

@property (strong, nonatomic) NSNumber *noteIdx;

@property (strong, nonatomic) NSNumber *noteId;

@end
