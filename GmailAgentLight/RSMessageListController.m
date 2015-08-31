//
//  RSMessageListController.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 26.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSMessageListController.h"
#import "RSMessage.h"



@interface RSMessageListController ()

@end

@implementation RSMessageListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
   
    
    self.finalMessageArray = [NSMutableArray array];

}

- (void) viewDidAppear:(BOOL)animated {
    
    int firstgroupOfMessages = 15;
    
    for (int i = 0; i < firstgroupOfMessages; i++) {
        
        NSString *messageId = [[self.mailListArray objectAtIndex:i] objectForKey:@"id"];
        
        if (i != firstgroupOfMessages - 1) {
            
            [[RSServerManager sharedManager] getRepresentationOfAMessage:messageId onSuccess:^(RSMessage *result) {
                
                [self.finalMessageArray addObject:result];
                
            } onFailure:^(NSError *error, NSInteger statusCode) {
                
            }];
            
        } else {
            
            [[RSServerManager sharedManager] getRepresentationOfAMessage:messageId onSuccess:^(RSMessage *result) {
                
                [self.finalMessageArray addObject:result];
                [self.tableView reloadData];
                
            } onFailure:^(NSError *error, NSInteger statusCode) {
                
            }];
        }
    }
    
  ////////
    
    [self loadSortedMail];
    
    
    
}


- (void) loadSortedMail {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        if (self.mailListArray.count != 0) {
            
            self.sentMessageArray = [NSMutableArray array];
            self.inboxMessageArray = [NSMutableArray array];
            
            
            if (self.sentMessageArray.count == 0 && self.inboxMessageArray.count == 0) {
                
                for (NSDictionary *msgDict in self.mailListArray) {
                    NSString *messgeId = [msgDict objectForKey:@"id"];
                    [[RSServerManager sharedManager] getRepresentationOfAMessage:messgeId onSuccess:^(RSMessage *result) {
                        
                        if (result.currentLabels & RSSent) {
                            
                            [self.sentMessageArray addObject:result];
                            
                        } else if (result.currentLabels & RSInbox) {
                            
                            [self.inboxMessageArray addObject:result];
                            
                        }
                        
                        
                    } onFailure:^(NSError *error, NSInteger statusCode) {
                        
                        
                    }];
                }
                
            }
    
        }
       
    });
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API


- (void)getRepresentationOfMessages:(NSArray *)arrayOfDictMessages {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        
        for (int i = 0; i <= arrayOfDictMessages.count - 1; i++) {
        NSString * messageId = [[arrayOfDictMessages objectAtIndex:i] objectForKey:@"id"];
        if (i < arrayOfDictMessages.count - 1) {
            [[RSServerManager sharedManager] getRepresentationOfAMessage:messageId
                                                               onSuccess:^(RSMessage *result) {
                                                                   
                                                                       [self.finalMessageArray addObject:result];
                                                                   
                                                               }
                                                               onFailure:^(NSError *error, NSInteger statusCode) {
                                                                   
                                                               }];
        } else if (i == arrayOfDictMessages.count - 1) {
            
            [[RSServerManager sharedManager] getRepresentationOfAMessage:messageId
                                                               onSuccess:^(RSMessage *result) {
                                                                   
                                                                       [self.finalMessageArray addObject:result];
                                                                       [self.tableView reloadData];
                                                                
                                                               }
                                                               onFailure:^(NSError *error, NSInteger statusCode) {
                                                                   
                                                               }];
        }
    }
        
    });
    
}



#pragma mark - UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
 
    
    if (self.labelSegments.selectedSegmentIndex == 0) {
        
        return [self.mailListArray count];

    } else if (self.labelSegments.selectedSegmentIndex == 1) {
        
        return [self.sentMessageArray count];
        
    } else if (self.labelSegments.selectedSegmentIndex == 2) {
        
        return [self.inboxMessageArray count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (self.labelSegments.selectedSegmentIndex == 0) {
        
        NSString *identefier = @"messageCell";
        UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identefier];
        
        messageCell.textLabel.font = [UIFont systemFontOfSize:12.f];
        messageCell.textLabel.numberOfLines = 3;
        
        if (self.finalMessageArray.count != 0) {
        if (indexPath.row < self.finalMessageArray.count) {
            
            RSMessage *item = [self.finalMessageArray objectAtIndex:indexPath.row];
            messageCell.textLabel.text  = [NSString stringWithFormat:@"%d : %@",indexPath.row + 1, item.snippet];
        }
        
        if (indexPath.row >= self.finalMessageArray.count) {
            

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *messageId = [[self.mailListArray objectAtIndex:indexPath.row-1] objectForKey:@"id"];
            [[RSServerManager sharedManager] getRepresentationOfAMessage:messageId onSuccess:^(RSMessage *result) {
                messageCell.textLabel.text  = [NSString stringWithFormat:@"%d : %@",indexPath.row + 1, result.snippet];
                [self.finalMessageArray addObject:result];
                
            } onFailure:^(NSError *error, NSInteger statusCode) {
                
                
                    }];
                
                });

            }
       
        }
        return messageCell;
        
    } else if (self.labelSegments.selectedSegmentIndex == 1) {
        
        NSString *identefier = @"messageCell2";
        UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identefier];
        
        if (!messageCell) {
            messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identefier];
        }
        
        messageCell.textLabel.font = [UIFont systemFontOfSize:12.f];
        messageCell.textLabel.numberOfLines = 3;
        
        RSMessage *sentMsg = [self.sentMessageArray objectAtIndex:indexPath.row];
        
        messageCell.textLabel.text  = [NSString stringWithFormat:@"%d : %@",indexPath.row + 1, sentMsg.snippet];
        
        return messageCell;
        
        
        
    } else if (self.labelSegments.selectedSegmentIndex == 2) {
        
        NSString *identefier = @"messageCell3";
        UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identefier];
        
        if (!messageCell) {
            messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identefier];
        }
        
        messageCell.textLabel.font = [UIFont systemFontOfSize:12.f];
        messageCell.textLabel.numberOfLines = 3;
        
        RSMessage *inboxMsg = [self.finalMessageArray objectAtIndex:indexPath.row];
        
         messageCell.textLabel.text  = [NSString stringWithFormat:@"%d : %@",indexPath.row + 1, inboxMsg.snippet];
        
        return messageCell;
        
    }
    
    
    
    
    
  
    
    
    
    
    

   /* if (!messageCell) {
        messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identefier];
    }
  */
    return 0;
}

- (IBAction)allMessages:(id)sender {

        [self.tableView reloadData];
}

- (IBAction)sentMessages:(id)sender {
       
        [self.tableView reloadData];
}

- (IBAction)inboxMessages:(id)sender {
    
        [self.tableView reloadData];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
