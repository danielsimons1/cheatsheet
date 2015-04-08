//
//  CSTabBarViewController.m
//  CheatSheet
//
//  Created by Daniel Simons on 4/5/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "CSTabBarViewController.h"
#import "DetailViewController.h"
#import "ScreenshotsViewController.h"
#import "CSData.h"

@interface CSTabBarViewController ()

@end

@implementation CSTabBarViewController


#pragma mark - Managing the detail item

- (void)setDetailItem:(CSData *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        DetailViewController *detailViewController = (DetailViewController *)self.childViewControllers.firstObject;
        detailViewController.tabBarDelegate = self;
        [detailViewController setDetailItem:_detailItem];
        
        ScreenshotsViewController * screenshotsViewController = (ScreenshotsViewController *)self.childViewControllers.lastObject;
        screenshotsViewController.tabBarDelegate = self;
        [screenshotsViewController setScreenshots:self.detailItem.screenshots];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.detailItem.title;
    self.delegate = self;
    UITabBarItem *screenshotButtonItem = self.tabBar.items.lastObject;
    screenshotButtonItem.badgeValue = [[NSNumber numberWithInteger:[self.detailItem.screenshots count]] stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)incrementTabBarBadgeValue {
    UITabBarItem *screenshotButtonItem = self.tabBar.items.lastObject;
    screenshotButtonItem.badgeValue = [[NSNumber numberWithInteger:[screenshotButtonItem.badgeValue integerValue] + 1] stringValue];
}

- (void)decrementTabBarBadgeValue {
    UITabBarItem *screenshotButtonItem = self.tabBar.items.lastObject;
    NSInteger badgeValue = [screenshotButtonItem.badgeValue integerValue] - 1;
    screenshotButtonItem.badgeValue = [[NSNumber numberWithInteger:badgeValue] stringValue];
    
    //Go back to Capture View Controller if there are no more screenshots
    if (badgeValue == 0) {
        [self setSelectedIndex:0];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[ScreenshotsViewController class]] && [self.detailItem.screenshots count] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You Have No Screenshots" message:@"Tap the Capture button to create a screenshot!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    } else if ([viewController isKindOfClass:[ScreenshotsViewController class]]) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [[self.viewControllers firstObject] setEditing:editing animated:animated];
}

@end
