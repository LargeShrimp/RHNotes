//
//  RHNoteViewController.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "RHNoteViewController.h"
#import "RHNoteTableView.h"
#import "NoteIndexEntity.h"
#import "NoteEntity.h"
#import "NotesDBManager.h"
#import "NotesIndexDBManager.h"
#import "RHNewNoteViewController.h"
#import "JumpPagesHandler.h"
@interface RHNoteViewController ()
@property (strong, nonatomic) RHNoteTableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

@end

@implementation RHNoteViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     [self fetchNotesData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = self.noteIndexEntity.name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configRithItem];
    
    self.tableView = [[RHNoteTableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
  
}
- (void)configRithItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(newNote)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Actions
- (void)newNote {
//    RHNewNoteViewController *newNoteController = [[RHNewNoteViewController alloc]init];
//    newNoteController.noteIndexEntity = self.noteIndexEntity;
//    [self.navigationController pushViewController:newNoteController animated:YES];    
    [JumpPagesHandler jump2NewNoteController:self.noteIndexEntity noteModel:NoteModelNew];
}

- (void)fetchNotesData {

    self.notes = [[NotesDBManager queryAllDataWithClass:[NoteEntity class]] mutableCopy];
//    self.notes =   [[NotesDBManager findByColumn:@"index_id" columnValue:[NSString stringWithFormat:@"%@",self.noteIndexEntity.noteIdxId] withClass:[NoteEntity class]] mutableCopy];
    [self.tableView setNotes:[self.notes copy]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
