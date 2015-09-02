//
//  QuestionsTableViewCell.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/27/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString * questionText;
@property (weak, nonatomic) IBOutlet UILabel *questionsLabel;


@end
