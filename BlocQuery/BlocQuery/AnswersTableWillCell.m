//
//  AnswersTableWillCell.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/1/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "AnswersTableWillCell.h"
#import <Parse/Parse.h>

@interface AnswersTableWillCell()

@property (nonatomic, assign) BOOL liked;
@property (weak, nonatomic) IBOutlet UIButton *heardButton;

@end


@implementation AnswersTableWillCell

-(void) setDefaultVoteStatus:(BOOL)defaultVoteStatus {
    _defaultVoteStatus = defaultVoteStatus;
    
    NSString *imageNamed = [NSString new];
    
    if (self.defaultVoteStatus == YES){
        imageNamed = @"Icon_Dark";
    } else {
        imageNamed = @"Icon_Grey";
    }
    
    UIImage *heartState = [UIImage imageNamed:imageNamed];
    [self.heardButton setImage:heartState forState:UIControlStateNormal];
    
}

- (IBAction)pressHeart:(id)sender {
    
    NSString *imageNamed = [NSString new];
    NSArray *arrayWithTwoStrings = [self.votesLabel.text componentsSeparatedByString:@" "];
    
    if (self.liked == NO) {
        imageNamed = @"Icon_Dark";
        self.votesLabel.text = [NSString stringWithFormat:@"%ld votes", [[arrayWithTwoStrings objectAtIndex:0] integerValue] + 1];
        
        PFObject *point = [PFObject objectWithoutDataWithClassName:@"Answers" objectId:self.answerID];
        [point incrementKey:@"votes" byAmount:[NSNumber numberWithInt:1]];

        PFRelation *user = [point relationForKey:@"likes"];
        [user addObject:[PFUser currentUser]];
        
        [point saveInBackground];
        
        self.liked = YES;
    } else {
        imageNamed = @"Icon_Grey";
        self.votesLabel.text = [NSString stringWithFormat:@"%ld votes", [[arrayWithTwoStrings objectAtIndex:0] integerValue] - 1];
        
        PFObject *point = [PFObject objectWithoutDataWithClassName:@"Answers" objectId:self.answerID];
        [point incrementKey:@"votes" byAmount:[NSNumber numberWithInt:-1]];
        
        PFRelation *user = [point relationForKey:@"likes"];
        [user removeObject:[PFUser currentUser]];
        
        [point saveInBackground];
        self.liked = NO;
    }
    
    UIImage *heartState = [UIImage imageNamed:imageNamed];
    [(UIButton *)sender setImage:heartState forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    UIColor *backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = backgroundColor;
    
    self.answerLabel.clipsToBounds = YES;
    
    self.liked = NO;
    
    NSString *imageNamed = [NSString new];

    if (self.defaultVoteStatus == YES){
        imageNamed = @"Icon_Dark";
    } else {
        imageNamed = @"Icon_Grey";
    }
    
    UIImage *heartState = [UIImage imageNamed:imageNamed];
    [self.heardButton setImage:heartState forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
