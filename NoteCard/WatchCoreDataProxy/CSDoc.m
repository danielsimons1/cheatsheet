//
//  CSDoc.m
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "CSDoc.h"

@implementation CSDoc

@synthesize fullImage  = _fullImage;


- (id)initWithFullImage:(NSData *)fullImage {
    if ((self = [super init])) {
        self.fullImage = fullImage;
    }
    return self;
}
@end
