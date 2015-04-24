//
//  CSScreenshot.h
//  NoteCard
//
//  Created by Daniel Simons on 4/3/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CSData;

@interface CSScreenshot : NSManagedObject

@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) CSData *data;
@property (nonatomic, retain) NSNumber *scale;
@property (nonatomic, retain) NSNumber *translationX;
@property (nonatomic, retain) NSNumber *translationY;

@end
