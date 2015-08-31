//
//  RSSendMsgController.m
//  GmailAgentLight
//
//  Created by Roma Chopovenko on 8/24/15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSSendMsgController.h"
#import "RSServerManager.h"

@interface RSSendMsgController ()

@end

@implementation RSSendMsgController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [self.addresseeField      resignFirstResponder];
    [self.subjectField        resignFirstResponder];
    [self.typeMessageTextView resignFirstResponder];
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addresseeField.delegate      = self;
    self.subjectField.delegate        = self;
    self.typeMessageTextView.delegate = self;
    
    
    self.navigationItem.title = @"Send message";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (NSString *) encodeToBase64 {
    
    NSString *to        = self.addresseeField.text;
    NSString *subject   = self.subjectField.text;
    NSString *textOfMsg = self.typeMessageTextView.text;
    
    NSString *preparedText = [NSString stringWithFormat:@"From:\nTo: %@\nSubject: %@\nDate:\nMessage-ID:\n%@", to, subject, textOfMsg];
    
    
    // Create NSData object
    NSData *nsdata = [preparedText dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    //NSLog(@"%@", base64Encoded);
    
    return base64Encoded;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sendButton:(id)sender {
    
    NSString *rawBase64String = [self encodeToBase64];
    
    [[RSServerManager sharedManager] sendEmailMessage:rawBase64String onSuccess:^(__autoreleasing id *result) {
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    
    
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
