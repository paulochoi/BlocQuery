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
#import "QuestionPopUpViewController.h"


@interface QuestionsTableViewController ()  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, QuestionPopUpViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *questions;

@end

@implementation QuestionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [PFUser logOut];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIColor *backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
    self.tableView.backgroundView = [[UIView alloc]initWithFrame:self.tableView.bounds];
    self.tableView.backgroundView.backgroundColor = backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (IBAction)pressPlus:(id)sender {
}



- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGRect frame = self.navigationItem.titleView.frame;
    frame.origin.x = 0;
    self.navigationItem.titleView.frame = frame;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]){
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
        [loginViewController setDelegate:self];
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self];
        
        [loginViewController setSignUpController:signUpViewController];
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserverForName:@"picFetchComplete" object:nil queue:nil usingBlock:^(NSNotification *note) {
//            [self.tableView reloadData];
//        }];
        
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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Questions"];
    [query orderByDescending:@"createdAt"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (!error) {
            for (PFObject *object in objects) {
                
                Questions *question = [[Questions alloc] initWithParseObject:object];
                [tempArray addObject:question];
            }
        } else {
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        self.questions = [tempArray mutableCopy];
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"picFetchComplete" object:nil queue:nil usingBlock:^(NSNotification *note) {
            
            NSIndexPath *rowToReload = [NSIndexPath indexPathForRow:[self.questions indexOfObject:note] inSection:0];
            NSArray *rowArray = [NSArray arrayWithObjects:rowToReload, nil];
            [self.tableView reloadRowsAtIndexPaths:rowArray withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }];

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
    //UITableViewCell *cell = [tableView dequeu eReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell){
        // Configure the cell...
        //NSLog(@"%@======" , self.questions[indexPath.row]);
        Questions *item = self.questions[indexPath.row];
        
        //cell.questionsLabel.text = self.questions[indexPath.row];
        cell.questionsLabel.text = item.question;
        cell.answersNumber.text = [NSString stringWithFormat:@"%ld answers" , item.voteCount];
        
        if (item.voteCount == 0) {
            cell.star2.alpha = 0;
            cell.star3.alpha = 0;
        } else if (item.voteCount < 4) {
            cell.star3.alpha = 0;
        }
        
        cell.questionAvatar.file = item.profilePic;
        [cell.questionAvatar loadInBackground];
        

    }

    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segue"]) {
        
        AnswersViewController *answer = segue.destinationViewController;
        Questions *question = (Questions *)sender;
        
        answer.question = question;
    } else if ([segue.identifier isEqualToString:@"presentPopup"]) {
        ((QuestionPopUpViewController *)segue.destinationViewController).delegate = self;
    }
}

#pragma mark - QuestionPopUpViewControllerDelegate

-(void)questionPopUpViewController:(QuestionPopUpViewController *)controller shouldPostQuestion:(NSString *)question {
    //insert the question into the table
    
    PFObject *newQuestion = [PFObject objectWithClassName:@"Questions"];
    newQuestion[@"text"] = question;
    newQuestion[@"questionUser"] = [PFUser currentUser];
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successful");
            
            Questions *question = [[Questions alloc] initWithParseObject:newQuestion];
            
            [controller dismissViewControllerAnimated:YES completion:^{
                [self.questions insertObject:question atIndex:0];
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            
        } else {
            // There was a problem, check error.description
            NSLog(@"Not Successful");
        }
    }];

}


@end