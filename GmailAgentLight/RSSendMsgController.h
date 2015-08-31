//
//  RSSendMsgController.h
//  GmailAgentLight
//
//  Created by Roma Chopovenko on 8/24/15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSendMsgController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *addresseeField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextView *typeMessageTextView;
- (IBAction)sendButton:(id)sender;

- (NSString *) encodeToBase64;




@end
