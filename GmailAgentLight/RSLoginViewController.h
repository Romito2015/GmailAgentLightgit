//
//  RSViewController.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAccessToken;

@interface RSLoginViewController : UIViewController

@property (strong, nonatomic) RSAccessToken *accessToken;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;




@end
