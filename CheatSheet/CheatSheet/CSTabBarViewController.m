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
        [screenshotsViewController setScreenshots:self.detailItem.screenshots];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.detailItem.title;
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

- (void)updateTabBarBadgeValue {
    UITabBarItem *screenshotButtonItem = self.tabBar.items.lastObject;
    screenshotButtonItem.badgeValue = [[NSNumber numberWithInteger:[screenshotButtonItem.badgeValue integerValue] + 1] stringValue];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

@end
