//
//  RHNoteViewController.h
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
// note 列表

#import "BaseViewController.h"
@class NoteIndexEntity;
@interface RHNoteViewController : BaseViewController

@property (strong, nonatomic)  NoteIndexEntity *noteIndexEntity;

@end
