//
//  User.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;


@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

@property (nonatomic, strong) NSString *followers;
@property (nonatomic, strong) NSString *following;
@property (nonatomic, strong) NSString *numtweets;

@property (nonatomic, strong) NSString *headerImgUrl;



- (id) initWithDictionary:(NSDictionary *) dictionary ;

+ (User *) currentUser;
+ (void) setCurrentUser:(User *) currentUser;

+ (void) logout;


@end
