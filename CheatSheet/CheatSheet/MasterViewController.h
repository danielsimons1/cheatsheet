//
//  MasterViewController.h
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class CSTabBarViewController;

@interface MasterViewController : UITableViewController


@property (strong, nonatomic) CSTabBarViewController *tabBarController;


@end

