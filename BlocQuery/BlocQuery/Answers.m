
//
//  Answers.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "Answers.h"

@implementation Answers

-(id) initWithParseObject: (PFObject *) parseObject {
    if (self) {
        self.answer = parseObject[@"text"];
        self.votes = (NSNumber *)parseObject[@"votes"];
        self.answerID = parseObject.objectId;
        self.voted = NO;
        
        PFQuery *query = [(PFRelation *)parseObject[@"likes"] query];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            
            for (PFUser *object in results) {
                
                if (object == [PFUser currentUser]) {
                    self.voted = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"voteFetchComplete" object:self];
                }
            }
        }];
    }
    
    return self;
}

-(void) postAnswers {
    

}

@end
