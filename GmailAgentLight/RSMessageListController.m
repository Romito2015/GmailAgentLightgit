//
//  RSMessageListController.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 26.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSMessageListController.h"
#import "RSMessageInList.h"



@interface RSMessageListController ()

@property (strong, nonatomic) NSString *messageID;
@property (strong, nonatomic) NSString *threadID;

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
    self.mailList = [[RSMessageInList alloc] init];
    [self geMessagesFromServer];
   
}

- (void) viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) geMessagesFromServer {
    
    [[RSServerManager sharedManager] getMessagesList:self.accessToken
                                           onSuccess:^(RSMessageInList *result) {
                                               
                                               // result ЭТО ОБЪЕКТ НЕСУЩИЙ В СЕБЕ НУЖНЫЕ ДАННЫЕ
                                               // self.mailList ЭТО ПРОПЕРТИ КУДА Я ХОЧУ СОХРАНИТЬ ДАННЫЕ

                                               self.mailList = result;
                                               
                                            /* dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.tableView reloadData];
                                             });*/
                                               
                                               [self.tableView reloadData];
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               
                                           }];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger value = [self.mailList.messagesArray count];
    
    return value;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identefier = @"messageCell";
    UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identefier];
    
    
    NSDictionary *item = [self.mailList.messagesArray objectAtIndex:indexPath.row];
    
        self.messageID = [item objectForKey:@"id"];
        self.threadID  = [item objectForKey:@"threadId"];
        messageCell.textLabel.numberOfLines = 2;
        messageCell.textLabel.text  = [NSString stringWithFormat:@"Id:%@\nThread:%@",
                                                                 self.messageID, self.threadID];
   
    if (!messageCell) {
        messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identefier];
    }
  
    return messageCell;
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
