//
//  InterfaceController.m
//  CheatSheet WatchKit Extension
//
//  Created by Daniel Simons on 3/31/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreData/CoreData.h>
#import "DataAccess.h"
#import "CSData.h"

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
    NSUInteger count = [[dataAccess.fetchedResultsController sections][0] numberOfObjects];
    [self.tableView setNumberOfRows:count withRowType:@"CustomTableRowController"];
    NSArray *fetchedObjects = [[dataAccess fetchedResultsController] fetchedObjects];
    for (CSData *data in fetchedObjects) {
        NSInteger index = [fetchedObjects indexOfObject:data];
        [[self.tableView rowControllerAtIndex:index] setTitle:data.title];
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

@end



