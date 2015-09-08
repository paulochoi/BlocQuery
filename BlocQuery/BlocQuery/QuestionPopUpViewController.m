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
    PFObject *newQuestion = [PFObject objectWithClassName:@"Questions"];
    newQuestion[@"text"] = self.textView.text;
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"Successful");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                            message:@"Your question was submitted"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            // There was a problem, check error.description
            NSLog(@"Not Successful");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
