//
//  SecondInterfaceController.m
//  CheatSheet
//
//  Created by Daniel Simons on 4/1/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "SecondInterfaceController.h"
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>


@interface SecondInterfaceController()

@end


@implementation SecondInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    //[[DataAccess sharedInstance] getFullImageForDoc:doc];
    [self.imageView setImageData:[context fullImage]];
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



