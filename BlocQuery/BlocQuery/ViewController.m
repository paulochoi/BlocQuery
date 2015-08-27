//
//  ViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/25/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



@interface ViewController ()  <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    [PFUser logOut];
    
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
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates
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

@end