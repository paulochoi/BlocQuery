//
//  Answers.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Questions.h"
#import <Parse/Parse.h>


@interface Answers : NSObject

@property (nonatomic, strong) Questions *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSNumber* votes;
@property (nonatomic, strong) NSString *answerID;
@property (nonatomic, assign) BOOL voted;


-(id) initWithParseObject: (PFObject *) parseObject;
-(void) postAnswers;

@end
