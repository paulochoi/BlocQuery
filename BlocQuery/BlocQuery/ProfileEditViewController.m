//
//  ProfileEditViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 9/8/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "ProfileEditViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ProfileEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;

@end

@implementation ProfileEditViewController

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)update:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId
                                 block:^(PFObject *object, NSError *error) {
                                     object[@"firstName"] = self.firstName.text;
                                     object[@"lastName"] = self.lastName.text;
                                     [object saveInBackground];
                                 }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
                self.firstName.text = object[@"firstName"];
                self.lastName.text = object[@"lastName"];
                
                self.profileImage.file = (PFFile *)object[@"profilePic"];
                [self.profileImage loadInBackground];
            }
        } else {
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
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
