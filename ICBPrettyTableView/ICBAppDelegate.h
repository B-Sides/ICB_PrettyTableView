//
//  ICBAppDelegate.h
//  ICBPrettyTableView
//
//  Created by James Van Metre on 11/17/11.
//  Copyright (c) 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICBTableViewController;

@interface ICBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ICBTableViewController *viewController;

@end
