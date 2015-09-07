//
//  AnswersTableWillCell.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/1/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "AnswersTableWillCell.h"

@implementation AnswersTableWillCell

- (void)awakeFromNib {
    // Initialization code
    
    UIColor *backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = backgroundColor;
    
    self.answerLabel.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
