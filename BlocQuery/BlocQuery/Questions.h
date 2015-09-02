//
//  Questions.h
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Questions : NSObject

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *questionID;

-(id) initWithParseObject: (Parse *) parseObject;


@end
