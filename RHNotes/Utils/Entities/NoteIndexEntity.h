//
//  NoteIndexEntity.h
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "BaseEntity.h"
#import <MTLFMDBAdapter.h>
@interface NoteIndexEntity : BaseEntity<MTLFMDBSerializing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *noteIdxId;
@property (strong, nonatomic) NSNumber *notesCount;

@end
