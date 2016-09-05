//
//  RHNoteTableView.m
//  RHNotes
//
//  Created by taitanxiami on 9/5/16.
//  Copyright © 2016 taitanxiami. All rights reserved.
//

#import "RHNoteTableView.h"
#import "NoteEntity.h"


static NSString *const NOTECELLINTITY = @"NOTECELLINTITY";

@implementation RHNoteTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        [self  setup];
    }
    
    return self;
}

- (void)setup {
    
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOTECELLINTITY];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NOTECELLINTITY];
    }
    NoteEntity *entity = _notes[indexPath.row];
    
    cell.textLabel.text = entity.content;
//    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",entity.notesCount];
//    cell.detailTextLabel.textColor = [UIColor redColor];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)setNotesIndex:(NSArray *)notes {
    _notes = notes;
    [self reloadData];
}


@end
