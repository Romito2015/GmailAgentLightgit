//
//  RSMessageInList.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 30.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//
typedef enum {
    
    RSSent,
    RSInbox,
    RSOther
    
    
} RSMessageLabel;



#import <Foundation/Foundation.h>

@interface RSMessage : NSObject

@property (strong, nonatomic) NSString *messageId;
@property (strong, nonatomic) NSString *snippet;
@property (assign, nonatomic) NSMutableArray *labelIds;
@property (assign, nonatomic) RSMessageLabel currentLabel;

- (id) initWithResponse:(NSDictionary *)responseList;

@end
