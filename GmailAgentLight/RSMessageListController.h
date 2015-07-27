//
//  RSMessageListController.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 26.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAccessToken.h"

@interface RSMessageListController : UIViewController
@property (strong, nonatomic) RSAccessToken *accessToken;
@end
