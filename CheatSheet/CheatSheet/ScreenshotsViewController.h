//
//  ScreenshotsViewController.h
//  CheatSheet
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenshotsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *screenshotCollectionView;

@property (strong, nonatomic) NSMutableSet *screenshots;
@end