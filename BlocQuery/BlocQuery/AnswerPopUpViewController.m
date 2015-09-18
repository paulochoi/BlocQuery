//
//  AnswerPopUpViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/17/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "AnswerPopUpViewController.h"
#import "Answers.h"

@interface AnswerPopUpViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation AnswerPopUpViewController

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)post:(id)sender {
    
    PFObject *point = [PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.question.questionID];
    [point incrementKey:@"answers" byAmount:[NSNumber numberWithInt:1]];
    
    PFObject *newAnswer = [PFObject objectWithClassName:@"Answers"];
    newAnswer[@"text"] = self.textField.text;
    newAnswer[@"question"] = point;
    newAnswer[@"votes"] = [[NSNumber alloc] initWithInt:0];
    
    [newAnswer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successful");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            // There was a problem, check error.description
            NSLog(@"Not Successful");
        }
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
