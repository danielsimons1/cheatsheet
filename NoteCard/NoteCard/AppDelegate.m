//
//  AppDelegate.m
//  NoteCard
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "AppDelegate.h"
#import "CSTabBarViewController.h"
#import "MasterViewController.h"
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>


#define kBundleKeyTechVersion               @"CFBundleVersion"
#define kUserDefaultKeyLastVersion          @"CFBundleVersionOfLastRun"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // At beginning of application:didFinishLaunchingWithOptions
    
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;

    //UINavigationController *masterNavigationController = splitViewController.viewControllers[0];
    //MasterViewController *controller = (MasterViewController *)masterNavigationController.topViewController;
    //controller.managedObjectContext = self.managedObjectContext;

    [self configureFirstLaunch];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    DataAccess *dataAccess = [DataAccess sharedInstance];
    [dataAccess saveContext];
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[CSTabBarViewController class]] && ([(CSTabBarViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

- (void)configureFirstLaunch {
    NSString* currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:kBundleKeyTechVersion];
    NSString* versionOfLastRun = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultKeyLastVersion];
    
    // Run only logic tied to specific to update vs.  first install
    if (versionOfLastRun == nil) {
        // First start after installing the app
        [self createInitialSeed];
        
    } else if (![versionOfLastRun isEqual:currentVersion]) {
        // App was updated since last run
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kUserDefaultKeyLastVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)createInitialSeed {


}

- (void)createNoteSheetEntity:(NSString*)title withImageName:(NSString*)imageName {
    DataAccess *dataAccess = [DataAccess sharedInstance];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CSData" inManagedObjectContext:dataAccess.managedObjectContext];
    CSData *managedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:dataAccess.managedObjectContext];
    
    [managedObject setTitle:title];
    
    NSData *dataImage = UIImageJPEGRepresentation([UIImage imageNamed:imageName], 0.0);
    
    [managedObject setValue:dataImage forKey:@"fullImage"];
    
    [dataAccess saveContext];
}

@end
