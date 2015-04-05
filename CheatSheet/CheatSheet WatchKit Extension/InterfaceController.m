//
//  InterfaceController.m
//  CheatSheet WatchKit Extension
//
//  Created by Daniel Simons on 3/31/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreData/CoreData.h>
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>
#import "CustomTableRowController.h"

@interface InterfaceController()

@end


@implementation InterfaceController


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    [self loadTableData];
}

- (void)loadTableData {
    DataAccess *dataAccess = [DataAccess sharedInstance];
    NSArray *fetchedObjects = [[dataAccess fetchedResultsController] fetchedObjects];
    NSUInteger count = [fetchedObjects count];
    [self.tableView setNumberOfRows:count withRowType:@"CustomTableRowController"];
    
    for (CSData *data in fetchedObjects) {
        NSInteger index = [fetchedObjects indexOfObject:data];
        CustomTableRowController *tableRowController = [self.tableView rowControllerAtIndex:index];
        [[tableRowController titleLabel] setText:[data title]];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    NSLog(@"index : %@", [[NSNumber numberWithInteger:rowIndex] stringValue]);
    
    [self pushControllerWithName:@"secondInterface" context:[table rowControllerAtIndex:rowIndex]];
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
    if ([segueIdentifier isEqualToString:@"secondInterface"]) {
        DataAccess *dataAccess = [DataAccess sharedInstance];
        NSArray *fetchedObjects = [[dataAccess fetchedResultsController] fetchedObjects];
        return [fetchedObjects objectAtIndex:rowIndex];
    }
    return nil;
}

@end



