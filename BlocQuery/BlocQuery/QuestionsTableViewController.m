//
//  ViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/25/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "QuestionsTableViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "QuestionsTableViewCell.h"
#import "Questions.h"
#import "AnswersViewController.h"



@interface ViewController ()  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *questions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [PFUser logOut];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Questions"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (!error) {
            for (PFObject *object in objects) {
                //NSLog(@"%@" , object[@"text"]);
                
                Questions *question = [Questions new];
                
                //[tempArray addObject:object[@"text"]];
                question.question = object[@"text"];
                question.questionID = object.objectId;
                [tempArray addObject:question];
            }
        } else {
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        self.questions = [tempArray copy];
        [self.tableView reloadData];
        
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]){
//        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
//        [loginViewController setDelegate:self];
//        
//        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
//        [signUpViewController setDelegate:self];
//        
//        [loginViewController setSignUpController:signUpViewController];
//        
//        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login and Signup Delegates
- (BOOL)logInViewController:(PFLogInViewController * __nonnull)logInController shouldBeginLogInWithUsername:(NSString * __nonnull)username password:(NSString * __nonnull)password {
    
    if (username && password && username.length != 0 && password.length ){
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all information" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    
    return NO;
}

- (void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user{
    [self dismissViewControllerAnimated:YES completion:nil];
    

}


- (void)logInViewController:(PFLogInViewController * __nonnull)logInController didFailToLogInWithError:(nullable NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Failed to login" message:@"Username or Password incorrect" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
}

- (void) logInViewControllerDidCancelLogIn:(PFLogInViewController * __nonnull)logInController {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (BOOL)signUpViewController:(PFSignUpViewController * __nonnull)signUpController shouldBeginSignUp:(NSDictionary * __nonnull)info {
    BOOL informationComplete = YES;
    
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }

    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

- (void) signUpViewController:(PFSignUpViewController * __nonnull)signUpController didSignUpUser:(PFUser * __nonnull)user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) signUpViewController:(PFSignUpViewController * __nonnull)signUpController didFailToSignUpWithError:(nullable NSError *)error{
    NSLog(@"Sign up failed");
}

- (void) signUpViewControllerDidCancelSignUp:(PFSignUpViewController * __nonnull)signUpController {
    NSLog(@"User dismissed the controller");
}

#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.questions count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
    Questions *item = self.questions[indexPath.row];
    [self performSegueWithIdentifier:@"segue" sender:item];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell){
        // Configure the cell...
        //NSLog(@"%@======" , self.questions[indexPath.row]);
        Questions *item = self.questions[indexPath.row];
        
        //cell.questionsLabel.text = self.questions[indexPath.row];
        cell.questionsLabel.text = item.question;
    }

    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segue"]) {
        
        AnswersViewController *answer = segue.destinationViewController;
        Questions *question = (Questions *)sender;
        
        answer.question = question;
    }
}

@end