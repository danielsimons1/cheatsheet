//
//  InterfaceController.h
//  NoteCard WatchKit Extension
//
//  Created by Daniel Simons on 3/31/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchCoreDataProxy/WatchCoreDataProxy.h>

@interface InterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tableView;

@end
