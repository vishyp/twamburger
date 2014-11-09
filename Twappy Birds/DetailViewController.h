//
//  DetailViewController.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/1/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"


@interface DetailViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *retweetImageAtTop;
@property (weak, nonatomic) IBOutlet UILabel *retweetTextAtTop;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *numRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numFavs;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFav:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@end
