//
//  QuestionsTableViewCell.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/27/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "QuestionsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface QuestionsTableViewCell()

@end

@implementation QuestionsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.questionsLabel.text = self.questionText;
    
    UIColor *backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = backgroundColor;
    
    //self.questionsLabel.clipsToBounds = YES;
    //[self.questionsLabel setPreferredMaxLayoutWidth:200.0];
    
    self.answersNumber.layer.borderColor = [UIColor whiteColor].CGColor;
    self.answersNumber.layer.borderWidth = 1.0;
    self.answersNumber.clipsToBounds = YES;
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
