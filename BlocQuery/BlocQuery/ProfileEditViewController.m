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

@interface ProfileEditViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (assign, nonatomic) BOOL profilePictureChanged;

@end

@implementation ProfileEditViewController

- (IBAction)updatePic:(id)sender {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    NSLog(@"%@",[info valueForKey:UIImagePickerControllerMediaURL]);
    
    self.profileImage.image = image;
    
    self.profilePictureChanged = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


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
    
    NSData *imageData = UIImagePNGRepresentation(self.profileImage.image);
    PFFile *imageFile = [PFFile fileWithName:@"ProfileImage.png" data:imageData];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            PFUser *user = [PFUser currentUser];
            user[@"firstName"] = self.firstName.text;
            user[@"lastName"] = self.lastName.text;
            if (self.profilePictureChanged) {
                user[@"profilePic"] = imageFile;
            }
            [user saveInBackground];
        }
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful"
                                                    message:@"Your profile has been updated"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];

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
