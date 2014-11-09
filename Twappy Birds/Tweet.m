//
//  Tweet.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet
- (id) initWithDictionary:(NSDictionary *) dictionary {
    if (self = [super init]) {
        self.text = dictionary[@"text"];
        self.idstr = dictionary[@"id_str"];
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        if ([dictionary objectForKey:@"retweeted_status"] != nil) {
           
            self.sender = [[User alloc] initWithDictionary:dictionary[@"retweeted_status"][@"user"]];
        } else {
            self.sender = nil;
        }
        self.retweetedMsg = [NSString stringWithFormat:@"%@ retweeted", self.sender.name];
        self.retweetCount = (int) dictionary[@"retweet_count"] ;
        self.favCount = (int) dictionary[@"favorite_count"] ;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        NSString *createdAtString = dictionary[@"created_at"];
        self.createdAt = [formatter dateFromString:createdAtString];
    }
    
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Tweet: <text = %@, author = %@, sender = %@, retmsg = %@, retct = %d, favct = %d>", self.text, self.author, self.sender, self.retweetedMsg, self.retweetCount, self.favCount];
}

+(NSArray *) tweetsWithArray:(NSArray *) array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dict]];
        
    }
    //NSLog(@"Tweet %@", array[0]);
    

    return tweets;
    
}
@end
