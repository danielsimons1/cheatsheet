//
//  DetailViewController.h
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSData.h"

@interface DetailViewController : UIViewController<UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate> {
    CGFloat firstX;
    CGFloat firstY;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) CSData *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)scaleImage:(UIPinchGestureRecognizer *)recognizer;
@property (strong, nonatomic) IBOutlet UIView *uploadPhotoView;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *screenshotButton;

@property (strong, nonatomic) IBOutlet UIView *screenshotView;
@property (strong, nonatomic) IBOutlet UIButton *captureButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *photoTabBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *screenshotsTabBarItem;

@property (strong, nonatomic) IBOutlet UITabBar *photoScreensTabBar;

@end

