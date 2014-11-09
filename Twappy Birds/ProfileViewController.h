//
//  ProfileViewController.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/8/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end

@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<ProfileViewControllerDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITableView *userTweetsTableView;
@property (strong, nonatomic) NSString *userHandle;

@end
