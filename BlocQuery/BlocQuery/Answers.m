
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
        self.votes = (NSInteger)parseObject[@"votes"];
        
    }
    
    return self;
}

-(void) postAnswers {
    

}

@end
