//
//  JumpPagesHandler.h
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHNewNoteViewController.h"

@class NoteIndexEntity;
@class NoteEntity;
@interface JumpPagesHandler : NSObject

+ (void)jump2NotesListWithMode:(NoteIndexEntity *) entity;

//+ (void)jump2NewNoteController:(NoteIndexEntity *) noteIdxEntity;
//+ (void)jump2NewNoteController:(NoteEntity *) noteEntity;
+ (void)jump2NewNoteController:(id)noteEntity noteModel:(NoteModel)model;


@end
