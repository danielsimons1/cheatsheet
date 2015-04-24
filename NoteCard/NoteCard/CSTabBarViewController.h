//
//  CSTabBarViewController.h
//  NoteCard
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSData.h"

@protocol CSUITabBarDelegate <NSObject>

- (void)incrementTabBarBadgeValue;
- (void)decrementTabBarBadgeValue;

@end

@interface CSTabBarViewController : UITabBarController<UINavigationControllerDelegate, CSUITabBarDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) CSData *detailItem;

@end
