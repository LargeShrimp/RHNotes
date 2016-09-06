//
//  RHMainViewController.m
//  RHNotes
//
//  Created by taitanxiami on 16/9/4.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "RHMainViewController.h"
#import "RHMainTableView.h"
#import "NotesDBManager.h"
#import "NotesIndexDBManager.h"
#import "NoteIndexEntity.h"
@interface RHMainViewController ()

@property (strong, nonatomic) RHMainTableView *tableView;
@property (strong, nonatomic)  UIAlertAction *okAction;
@property (strong, nonatomic) NSString *folder;
@property (strong, nonatomic) NSMutableArray *notesIndexArray;

@end

@implementation RHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Note";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configRithItem];
    
    self.tableView = [[RHMainTableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self fetchNotesIndexData];

}



- (void)configRithItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(newFolder)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Action
- (void)newFolder {

    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _okAction = nil;
    }]];
    
    _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveNewfolder];
    }];
    _okAction.enabled = NO;
    [alertView addAction:_okAction];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];

    }];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    
    UITextField *textField = notification.object;
    
    self.folder = textField.text;
    if (textField.text.length > 0) {
        _okAction.enabled = YES;
    }else {
        _okAction.enabled = NO;
    }
    
}

- (void)saveNewfolder {
    NoteIndexEntity *noteIndexEntity = [[NoteIndexEntity alloc]init];
    noteIndexEntity.name = self.folder;
    [NotesIndexDBManager insertOnDuplicateUpdate:noteIndexEntity];
    
    [self fetchNotesIndexData];
    _okAction = nil;
    _folder = nil;
}

- (void)fetchNotesIndexData {
    
    self.notesIndexArray = [[NotesIndexDBManager queryAllDataWithClass:[NoteIndexEntity class]] mutableCopy];
    if (self.notesIndexArray.count == 0) {
        NoteIndexEntity *noteIndexEntity = [[NoteIndexEntity alloc]init];
        noteIndexEntity.noteIdxId = @0;
        noteIndexEntity.name = @"默认";
        noteIndexEntity.notesCount = @0;
        [self.notesIndexArray addObject:noteIndexEntity];
        [NotesIndexDBManager insertOnDuplicateUpdate:noteIndexEntity];
    }
    [self.tableView setNotesIndex:[self.notesIndexArray copy]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
