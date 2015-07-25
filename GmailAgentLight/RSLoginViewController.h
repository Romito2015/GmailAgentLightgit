//
//  RSViewController.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAccessToken;

typedef void(^RSLoginCompletionBlock)(RSAccessToken *token);

@interface RSLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) RSAccessToken *accessToken;

- (id) initWithCompletionBlock:(RSLoginCompletionBlock) completion;

@end