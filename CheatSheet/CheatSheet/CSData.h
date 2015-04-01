//
//  CSData.h
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSDoc.h"

@class CSDoc;

@interface CSData : NSManagedObject

@property (nonatomic, retain) CSDoc *doc;
@property (nonatomic, retain) NSString *title;

- (id)initWithTitle:(NSString*)title doc:(CSDoc *)doc;

@end
