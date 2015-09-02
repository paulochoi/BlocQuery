//
//  QuestionsTableViewCell.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/27/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "QuestionsTableViewCell.h"

@interface QuestionsTableViewCell()

@end

@implementation QuestionsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.questionsLabel.text = self.questionText;
    NSLog(@"%@" ,self.questionText);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
