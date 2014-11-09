//
//  MenuViewController.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/7/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

@required
-(void)newViewSelected:(NSString *)code;

@end

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, assign) id<MenuViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;


@end
