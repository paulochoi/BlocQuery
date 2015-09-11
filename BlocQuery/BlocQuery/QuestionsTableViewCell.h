//
//  QuestionsTableViewCell.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/27/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUILabel.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface QuestionsTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString * questionText;
@property (weak, nonatomic) IBOutlet CustomUILabel *questionsLabel;
@property (weak, nonatomic) IBOutlet CustomUILabel *answersNumber;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet PFImageView *questionAvatar;

@end
