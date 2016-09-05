//
//  RHMainTableView.h
//  RHNotes
//
//  Created by taitanxiami on 16/9/4.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHMainTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *notesIndex;
@end
