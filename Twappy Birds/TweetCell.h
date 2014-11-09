//
//  TweetCell.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/31/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

extern NSString * const PlayOnTweetNotification;


@interface TweetCell : UITableViewCell

@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *retweetedLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopMarginConstraint;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (nonatomic) int rownum;

- (IBAction)onPlay:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *authorName;

@property (weak, nonatomic) IBOutlet UILabel *authorHandle;
- (IBAction)onUserClicked:(id)sender;

- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFav:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *onFav;
@end
