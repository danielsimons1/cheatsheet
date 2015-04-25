//
//  SecondInterfaceController.m
//  Note Card
//
//  Created by Daniel Simons on 4/1/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "SecondInterfaceController.h"
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>


@interface SecondInterfaceController()

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSMutableSet *screenshots;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *noScreenshotsLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *prevButton;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *nextButton;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@end


@implementation SecondInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    //[[DataAccess sharedInstance] getFullImageForDoc:doc];
    self.index = 0;
    self.screenshots = [context screenshots];
    [self.titleLabel setText:[context title]];
    if (self.screenshots.allObjects.count < 1) {
        self.noScreenshotsLabel.hidden = NO;
        self.imageView.hidden = YES;
        self.prevButton.hidden = YES;
        self.nextButton.hidden = YES;
    } else {
        self.noScreenshotsLabel.hidden = YES;
        self.imageView.hidden = NO;
        
        CSScreenshot *screenshot = self.screenshots.allObjects[self.index.integerValue];
        [self.imageView setImageData:[screenshot imageData]];
        self.prevButton.hidden = NO;
        self.nextButton.hidden = NO;
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
- (IBAction)didPressNext {
    self.index = [NSNumber numberWithInteger:[self.index integerValue] + 1];
    if (self.index.integerValue == self.screenshots.allObjects.count) {
        self.index = 0;
    }
    CSScreenshot *screenshot = self.screenshots.allObjects[self.index.integerValue];
    [self.imageView setImageData:screenshot.imageData];
}
- (IBAction)didPressPrevious {
    self.index = [NSNumber numberWithInteger:[self.index integerValue] - 1];
    if (self.index.integerValue < 0) {
        self.index = [NSNumber numberWithInteger:self.screenshots.allObjects.count - 1];
    }
    CSScreenshot *screenshot = self.screenshots.allObjects[self.index.integerValue];
    [self.imageView setImageData:screenshot.imageData];
}

@end



