//
//  RSViewController.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSLoginViewController.h"
#import "RSAccessToken.h"
#import "RSServerManager.h"
#import "RSMessageListController.h"


@interface RSLoginViewController () <UIWebViewDelegate>


@end

@implementation RSLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Login";
    NSString *urlString = @"https://accounts.google.com/o/oauth2/auth?"
                        "response_type=code&"
                        "scope=https://mail.google.com/&"
                        "access_type=offline&"
                        "login_hint=emailadress&"
                        "state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&"
                        "redirect_uri=http://localhost&"
                        "client_id=555621197106-tbhcihl4onod6560neusglq41i6g6m7f.apps.googleusercontent.com&"
                        "approval_prompt=force";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
   
    NSString *stringRequest = [[request URL] description];
   // NSLog(@"%@", stringRequest);
    
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        
        NSArray *array = [stringRequest componentsSeparatedByString:@"code="];
        if (array.count > 1) {
            NSString *code = [array lastObject];

            [[RSServerManager sharedManager] authorizeUser:code
                                            onSuccess:^(RSAccessToken *gmailToken) {
                                                self.accessToken = gmailToken;
                                                [self performSegueWithIdentifier:@"segueToMessageList" sender:self];
                                                
                                                
                                            }
                                            onFailure:^(NSError *error, NSInteger statusCode) {
                                            }];
        }
       
    }
    
    return YES;

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
   
    [self.indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.indicator stopAnimating];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueToMessageList"]) {
        
        
        RSMessageListController *destViewController = segue.destinationViewController;
        
            destViewController.navigationItem.title = @"List of messages";
        destViewController.accessToken = self.accessToken;
        
        }
    }




@end
