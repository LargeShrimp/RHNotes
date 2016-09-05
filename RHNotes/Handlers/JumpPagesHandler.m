//
//  JumpPagesHandler.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "JumpPagesHandler.h"
#import "RHNoteViewController.h"
#import "AppDelegate.h"
@implementation JumpPagesHandler

+ (void)jump2NotesListWithMode:(NoteIndexEntity *)entity {
    
    AppDelegate *delegate =  [UIApplication sharedApplication].delegate;
    RHNoteViewController *noteListController = [[RHNoteViewController alloc]init];
    noteListController.noteIndexEntity = entity;
    [delegate.mianNav pushViewController:noteListController animated:YES];    
}

@end
