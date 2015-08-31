//
//  RSMessageListController.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 26.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAccessToken.h"
#import "RSServerManager.h"


@interface RSMessageListController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RSAccessToken *accessToken;
@property (strong, nonatomic) NSArray *mailListArray;
@property (strong, nonatomic) NSMutableArray *finalMessageArray;
@property (strong, nonatomic) NSMutableArray *sentMessageArray;
@property (strong, nonatomic) NSMutableArray *inboxMessageArray;

//- (void) geMessagesFromServer;
- (void) getRepresentationOfMessages:(NSArray *) arrayOfDictMessages ;



@property (weak, nonatomic) IBOutlet UISegmentedControl *labelSegments;
- (IBAction)allMessages:(id)sender;
- (IBAction)sentMessages:(id)sender;
- (IBAction)inboxMessages:(id)sender;



@end
