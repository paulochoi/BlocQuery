//
//  QuestionPopUpViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/7/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "QuestionPopUpViewController.h"
#import <Parse/Parse.h>
#import "QuestionsTableViewController.h"


@interface QuestionPopUpViewController ()
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation QuestionPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.masksToBounds = YES;
}

- (IBAction)cancelQuery:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postQuestion:(id)sender {
    [self.delegate questionPopUpViewController:self shouldPostQuestion:self.textView.text];    
}

@end
