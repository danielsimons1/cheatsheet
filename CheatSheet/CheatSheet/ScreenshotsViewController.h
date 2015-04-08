//
//  ScreenshotsViewController.h
//  CheatSheet
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTabBarViewController.h"
#import "CSScreenshot.h"

@protocol ScreenshotsDelegate <NSObject>

- (void) deleteScreenshot:(CSScreenshot *)screenshot;

@end

@interface ScreenshotsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, ScreenshotsDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *screenshotCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSMutableSet *screenshots;
@property (strong, nonatomic) id<CSUITabBarDelegate> tabBarDelegate;

@end
