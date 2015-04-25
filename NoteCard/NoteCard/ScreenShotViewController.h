//
//  ScreenShotViewController.h
//  NoteCard
//
//  Created by Daniel Simons on 4/6/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenshotsViewController.h"
#import "CSScreenshot.h"

@interface ScreenShotViewController : UIViewController
@property (strong, nonatomic) CSScreenshot *screenshotDetailItem;
@property (strong, nonatomic) IBOutlet UIImageView *screenshotFullImage;

@property (strong, nonatomic) id<ScreenshotsDelegate> screenshotsDelegate;

@end
