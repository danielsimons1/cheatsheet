//
//  CSData.h
//  NoteCard
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CSData : NSManagedObject

@property (nonatomic, retain) NSData *fullImage;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableSet *screenshots;

- (id)initWithTitle:(NSString*)title fullImage:(NSData *)data;

@end
