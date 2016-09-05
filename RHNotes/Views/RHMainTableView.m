//
//  RHMainTableView.m
//  RHNotes
//
//  Created by taitanxiami on 16/9/4.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "RHMainTableView.h"
#import "NoteIndexEntity.h"
#import "JumpPagesHandler.h"

static NSString *const NOTECATEGORYCELL = @"NOTECATEGORYCELL";

@implementation RHMainTableView



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
    
    return _notesIndex.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NOTECATEGORYCELL];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NOTECATEGORYCELL];
    }
    NoteIndexEntity *entity = _notesIndex[indexPath.row];
    
    cell.textLabel.text = entity.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",entity.notesCount];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NoteIndexEntity *entity = _notesIndex[indexPath.row];
    [JumpPagesHandler jump2NotesListWithMode:entity];
}


- (void)setNotesIndex:(NSArray *)notesIndex {
    _notesIndex = notesIndex;
    [self reloadData];
}
@end
