//
//  ScreenShotViewController.m
//  NoteCard
//
//  Created by Daniel Simons on 4/6/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "ScreenShotViewController.h"
#import "ScreenshotsViewController.h"

@interface ScreenShotViewController ()

@end

@implementation ScreenShotViewController

- (void)setScreenshotDetailItem:(CSScreenshot *)screenshotDetailItem {
    if (_screenshotDetailItem != screenshotDetailItem) {
        _screenshotDetailItem = screenshotDetailItem;
        [self configureView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    UIBarButtonItem *btnUp = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIButtonBarArrowUp"] style:UIBarButtonItemStylePlain target:self action:@selector(previous)];
    UIBarButtonItem *btnDown = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIButtonBarArrowDown"] style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnDown, btnUp, nil]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    UIImage *fullImage = [UIImage imageWithData:[self.screenshotDetailItem imageData]];
    [self.screenshotFullImage setImage:fullImage];
}


- (void)next {
    ScreenshotsViewController *screenshotViewController = (ScreenshotsViewController *)[[[self.parentViewController.childViewControllers firstObject] childViewControllers] lastObject];
    NSInteger index = [[screenshotViewController.screenshots allObjects] indexOfObject:self.screenshotDetailItem];
    index = index + 1;
    if (index == [screenshotViewController.screenshots count]) {
        index = 0;
    }
    self.screenshotDetailItem = [[screenshotViewController.screenshots allObjects] objectAtIndex:index];
}

- (void)previous {
    ScreenshotsViewController *screenshotViewController = (ScreenshotsViewController *)[[[self.parentViewController.childViewControllers firstObject] childViewControllers] lastObject];
    NSInteger index = [[screenshotViewController.screenshots allObjects] indexOfObject:self.screenshotDetailItem];
    index = index - 1;
    if (index < 0) {
        index = [screenshotViewController.screenshots count] - 1;
    }
    self.screenshotDetailItem = [[screenshotViewController.screenshots allObjects] objectAtIndex:index];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didPressTrashCan:(UIBarButtonItem *)sender {
    [self.screenshotsDelegate deleteScreenshot:self.screenshotDetailItem];
}

- (IBAction)didPressShareButton:(UIBarButtonItem *)sender {
    NSString *screenshotText = @"Checkout this screenshot from Whiteboard Notes!";
    UIImage *image = self.screenshotFullImage.image;
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[image, screenshotText] applicationActivities:nil];
    
    activityVC.popoverPresentationController.sourceView = self.view;

    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTencentWeibo, UIActivityTypePostToTwitter,UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypePostToFlickr, UIActivityTypeCopyToPasteboard];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}

@end
