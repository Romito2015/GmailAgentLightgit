//
//  RSMessageInList.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 30.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMessageInList : NSObject

@property (strong, nonatomic) NSMutableArray *messagesArray;
@property (strong, nonatomic) NSString *nextPageToken;
@property (assign, nonatomic) NSInteger resultSizeEstimate;

- (id) initWithListResponse:(NSDictionary *)responseList;

@end
