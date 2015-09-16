//
//  Questions.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "Questions.h"

@implementation Questions

-(id) initWithParseObject: (PFObject *) parseObject {
    if (self) {
        self.question = parseObject[@"text"];
        self.questionID = parseObject.objectId;
        
//        PFQuery *query = [PFQuery queryWithClassName:@"Answers"];
//        [query whereKey:@"question" equalTo:[PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.questionID]];
        
        self.voteCount = [parseObject[@"answers"] integerValue];
        
        PFObject *userObject = (PFObject *)parseObject[@"questionUser"];

        PFQuery *queryUserProfile = [PFQuery queryWithClassName:@"_User"];
        
        [queryUserProfile whereKey:@"objectId" equalTo:userObject.objectId];
        
        [queryUserProfile findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if (!error) {
                self.profilePic = objects.firstObject[@"profilePic"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"picFetchComplete" object:nil];
                
            } else {
                
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
    return self;
}

@end
