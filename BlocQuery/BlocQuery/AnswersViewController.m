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


@interface AnswersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) NSArray *answers;


@end

@implementation AnswersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.questionLabel.text = self.question.question;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadAnswers];

}


- (void) loadAnswers {
    PFQuery *query = [PFQuery queryWithClassName:@"Answers"];

    [query whereKey:@"question" equalTo:[PFObject objectWithoutDataWithClassName:@"Questions" objectId:self.question.questionID]];
    
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
        cell.votesLabel.text = [NSString stringWithFormat:@"%d",(int)item.votes];
    }
    
    return cell;
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
