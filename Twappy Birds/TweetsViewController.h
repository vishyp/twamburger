//
//  TweetsViewController.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@protocol TweetsViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;
//-(void)startPanningAtLocation:(CGPoint) loc;
//-(void)endPanningAtLocation:(CGPoint) loc;
//- (void)panPanelRightAtLocation:(CGPoint) loc;

@required
- (void)movePanelToOriginalPosition;

@end


@interface TweetsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTable;
@property (nonatomic, assign) id<TweetsViewControllerDelegate> delegate;
- (IBAction)onMenuClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)onTableTapped:(UITapGestureRecognizer *)sender;
//- (IBAction)onTablePanned:(UIPanGestureRecognizer *)sender;

@end
