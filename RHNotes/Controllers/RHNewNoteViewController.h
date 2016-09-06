//
//  RHNewNoteViewController.h
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "BaseViewController.h"
@class NoteIndexEntity;
@class NoteEntity;
typedef NS_ENUM(NSUInteger, NoteModel) {
    NoteModelNew,
    NoteModelModify
};
@interface RHNewNoteViewController : BaseViewController
@property (strong, nonatomic)  NoteIndexEntity *noteIndexEntity;
@property (strong, nonatomic) NoteEntity *noteEntity;

@end
