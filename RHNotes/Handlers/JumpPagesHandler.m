//
//  JumpPagesHandler.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "JumpPagesHandler.h"
#import "RHNoteViewController.h"
//#import "NoteEntity.h"
#import "AppDelegate.h"
@implementation JumpPagesHandler

+ (void)jump2NotesListWithMode:(NoteIndexEntity *)entity {
    
    AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    RHNoteViewController *noteListController = [[RHNoteViewController alloc]init];
    noteListController.noteIndexEntity = entity;
    [delegate.mianNav pushViewController:noteListController animated:YES];    
}
+ (void)jump2NewNoteController:(id)noteEntity noteModel:(NoteModel)model {
    RHNewNoteViewController *newNoteController = [[RHNewNoteViewController alloc]init];
    
    NoteIndexEntity *noteIdxEntity = nil;
    NoteEntity *notesEntity = nil;
    if (model == NoteModelNew) {
        noteIdxEntity = noteEntity;
    }else {
        notesEntity = noteEntity;
    }
    newNoteController.noteEntity = notesEntity;
    newNoteController.noteIndexEntity = noteIdxEntity;
     AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
     [delegate.mianNav pushViewController:newNoteController animated:YES];
}
@end
