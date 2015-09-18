//
//  AnswersViewController.m
//  BlocQuery
//
//  Created by Paulo Choi on 8/31/15.
//  Copyright (c) 2015 Paulo Choi. All rights reserved.
//

#import "AnswersViewController.h"
#import <Parse/Parse.h>
#import "Answers.h"
#import "AnswersTableWillCell.h"
#import "AnswerPopUpViewController.h"


@interface AnswersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet CustomUILabel *questionLabel;
@property (strong, nonatomic) NSArray *answers;


@end

@implementation AnswersViewController
- (IBAction)tapButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.questionLabel.text = self.question.question;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.questionLabel.clipsToBounds = YES;
    
    //self.navigationItem.titleView = [self newTitleViewForTitle:@];
    
    [self loadAnswers];

}


- (UIView *)newTitleViewForTitle: (NSString *) title {
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.adjustsFontSizeToFitWidth = NO;
    
    [titleLabel sizeToFit];
    
    CGRect frame = titleLabel.frame;
    frame.size.width = 500;
    
    titleLabel.frame = frame;
    //titleLabel.backgroundColor = [UIColor redColor];
    
    return titleLabel;
}

- (void) loadAnswers {
    PFQuery *query = [PFQuery queryWithClassName:@"Answers"];

    [query whereKey:@"question" equalTo:[PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.question.questionID]];
    [query orderByDescending:@"votes"];

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (!error) {
            for (PFObject *object in objects) {
                
                Answers *answers = [[Answers alloc] initWithParseObject:object];
                [tempArray addObject:answers];
                
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        self.answers = [tempArray copy];
        [self.tableView reloadData];

    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnswersTableWillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell){
        // Configure the cell...
        //NSLog(@"%@======" , self.questions[indexPath.row]);
        Answers *item = self.answers[indexPath.row];
        
        cell.answerLabel.text = item.answer;
        cell.votesLabel.text = [NSString stringWithFormat:@"%@ votes",item.votes];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"answerSegue"]) {
        
        AnswerPopUpViewController *answer = segue.destinationViewController;
        Questions *question = self.question;
        
        answer.question = question;
    }

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
