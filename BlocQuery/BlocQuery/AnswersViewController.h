//
//  AnswersViewController.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"

@interface AnswersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Questions *question;

@end
