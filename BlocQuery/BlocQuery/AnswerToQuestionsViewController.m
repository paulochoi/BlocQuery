//
//  AnswerToQuestionsViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/12/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "AnswerToQuestionsViewController.h"
#import "Answers.h"
#import "CustomUILabel.h"

@interface AnswerToQuestionsViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *answerTextField;
@property (weak, nonatomic) IBOutlet CustomUILabel *titleLabel;

@end

@implementation AnswerToQuestionsViewController


//-(BOOL)textViewShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    NSLog(@"YEAP!");
//    return YES;
//}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
       
        [textView resignFirstResponder];
        NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
        
        PFObject *point = [PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.question.questionID];

        
        PFObject *newAnswer = [PFObject objectWithClassName:@"Answers"];
        newAnswer[@"text"] = newText;
        newAnswer[@"question"] = point;
        //newAnswer[@"votes"] = [[NSNumber alloc] initWithInt:0];
        
        [newAnswer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Successful");
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                // There was a problem, check error.description
                NSLog(@"Not Successful");
            }
        }];

        return NO;
        
    }
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.answerTextField.delegate = self;
    self.titleLabel.text = self.question.question;
    
}

- (void )didReceiveMemoryWarning {
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
