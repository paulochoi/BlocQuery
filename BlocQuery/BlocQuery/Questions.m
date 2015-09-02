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
    }
    
    return self;
}

@end
