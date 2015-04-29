//
//  SecondInterfaceController.m
//  Note Card
//
//  Created by Daniel Simons on 4/1/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "SecondInterfaceController.h"
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>
#import "ImageTableRowController.h"

@interface SecondInterfaceController()

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSMutableSet *screenshots;
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *fullImage;

@end


@implementation SecondInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    //[[DataAccess sharedInstance] getFullImageForDoc:doc];
    self.index = 0;
    self.screenshots = [context screenshots];
    //[self.titleLabel setText:[context title]];
    //self.noScreenshotsLabel.hidden = YES;
    //self.imageView.hidden = NO;
    [self.titleLabel setText:[context title]];
    [self.fullImage setImageData:[context fullImage]];
    NSData *imageData = [context fullImage];
    if (!imageData) {
        CSScreenshot *screenshot = self.screenshots.allObjects[self.index.integerValue];
        imageData = [screenshot imageData];
    }
    //[self.imageView setImageData:imageData];
    
    [self.tableView setNumberOfRows:self.screenshots.count withRowType:@"ImageTableRowController"];
    
    for (CSScreenshot *screen in self.screenshots.allObjects) {
        NSInteger index = [self.screenshots.allObjects indexOfObject:screen];
        ImageTableRowController *imageRowController = [self.tableView rowControllerAtIndex:index];
        [[imageRowController imageView] setImageData:[screen imageData]];
    }
    
    
    // Configure interface objects here.
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



