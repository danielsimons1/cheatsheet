//
//  CSDoc.h
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "CSData.h"

@class CSData;

@interface CSDoc : NSManagedObject

@property (strong) NSData *thumbImage;
@property (strong) NSData *fullImage;

- (id)initWithThumbImage:(NSData *)thumbImage fullImage:(NSData *)fullImage;

@end
