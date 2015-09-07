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
        
        PFQuery *query = [PFQuery queryWithClassName:@"Answers"];
        //[query whereKey:@"question" equalTo:self.questionID];
        [query whereKey:@"question" equalTo:[PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.questionID]];
        
        self.voteCount = [query countObjects];

        NSLog(@"%ld" ,(long)self.voteCount);
    }
    
    return self;
}

@end
