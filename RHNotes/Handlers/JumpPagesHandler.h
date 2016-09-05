//
//  JumpPagesHandler.h
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NoteIndexEntity;

@interface JumpPagesHandler : NSObject


+ (void)jump2NotesListWithMode:(NoteIndexEntity *)entity;
@end
