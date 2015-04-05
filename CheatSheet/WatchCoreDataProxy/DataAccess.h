//
//  DataAccess.h
//  CheatSheet
//
//  Created by Daniel Simons on 4/1/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CSData.h"
#import "CSScreenshot.h"
#import <CoreGraphics/CoreGraphics.h>

@interface DataAccess : NSObject <NSFetchedResultsControllerDelegate>

+ (DataAccess *)sharedInstance;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController * fetchedScreenshotsResultsController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)storeScreenshotForData:(CSData *)csdata screenshotData:(NSData *)pngData scale:(CGFloat)imageScale translationX:(CGFloat)imageTranslationX translationY:(CGFloat)imageTranslationY;

@end
