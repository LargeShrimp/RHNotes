//
//  RHNewNoteViewController.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "RHNewNoteViewController.h"
#import "NotesDBManager.h"
#import "NotesIndexDBManager.h"
#import "NoteEntity.h"
#import "NoteIndexEntity.h"

@interface RHNewNoteViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;

@property (assign, nonatomic) BOOL modifyed;

@property (strong, nonatomic) UIButton *finishButton;
@end

@implementation RHNewNoteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    [_textView becomeFirstResponder];
    _textView.font = [UIFont systemFontOfSize:15.0f];
    
    [self configRithItem];
    if (self.noteEntity != nil) {
        _textView.text = self.noteEntity.content;
    }
}
- (void)configRithItem {
    
    
    self.finishButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(modifyDone)];
    [self.finishButton addTarget:self action:@selector(modifyDone) forControlEvents:UIControlEventTouchUpInside];
    [self.finishButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.finishButton.userInteractionEnabled = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.finishButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)modifyDone {
    
    
    
    if (self.noteIndexEntity != nil) {
        
        NoteEntity *noteEntity = [[NoteEntity alloc]init];
        noteEntity.noteIdx = self.noteIndexEntity.noteIdxId;
        noteEntity.content = _textView.text;
        noteEntity.star = NO;
        noteEntity.creatAt = [NSDate date];
        noteEntity.lastModifyDate = [NSDate date];
        [NotesDBManager insertOnDuplicateUpdate:noteEntity];
        
        NSNumber *noteCount = self.noteIndexEntity.notesCount;
        noteCount = [NSNumber numberWithInteger:noteCount.integerValue + 1];
        self.noteIndexEntity.notesCount = noteCount;
        [NotesIndexDBManager insertOnDuplicateUpdate:self.noteIndexEntity];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        self.noteEntity.lastModifyDate = [NSDate date];
         [NotesDBManager insertOnDuplicateUpdate:self.noteEntity];
        
        [self.finishButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.finishButton.userInteractionEnabled = NO;

    }
    
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    [self.finishButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.finishButton.userInteractionEnabled = YES;
    if (self.noteEntity != nil) {
        self.noteEntity.content = textView.text;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
