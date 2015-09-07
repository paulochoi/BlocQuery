//
//  AnswersTableWillCell.h
//  BlocQuery
//
//  Created by Paulo Choi on 9/1/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUILabel.h"

@interface AnswersTableWillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CustomUILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;

@end
