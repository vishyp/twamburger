//
//  NewTweetController.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/1/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTweetController : UIViewController  <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UITextField *tweetField;
@property (weak, nonatomic) NSString *replyHandle;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

@end
