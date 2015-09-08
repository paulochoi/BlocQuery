//
//  QuestionPopUpViewController.h
//  BlocQuery
//
//  Created by Paulo Choi on 9/7/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionPopUpViewController;

@protocol QuestionPopUpViewControllerDelegate <NSObject>

- (void)questionPopUpViewController:(QuestionPopUpViewController *)controller shouldPostQuestion:(NSString *)question;

@end

@interface QuestionPopUpViewController : UIViewController
@property (weak, nonatomic) id<QuestionPopUpViewControllerDelegate> delegate;
@end
