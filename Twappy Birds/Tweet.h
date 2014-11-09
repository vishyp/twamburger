//
//  Tweet.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *author;
@property (nonatomic, strong) User *sender;
@property (nonatomic, strong) NSString *retweetedMsg;
@property (nonatomic,) int retweetCount;
@property (nonatomic) int favCount;
@property (nonatomic, strong) NSString *idstr;



- (id) initWithDictionary:(NSDictionary *) dictionary;

+(NSArray *) tweetsWithArray:(NSArray *) array;



@end
