//
//  Answers.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Questions.h"

@interface Answers : NSObject

@property (nonatomic, strong) Questions *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) NSInteger votes;

-(id) initWithParseObject: (PFObject *) parseObject;
-(void) postAnswers;

@end
