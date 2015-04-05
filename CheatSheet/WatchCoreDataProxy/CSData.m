//
//  CSData.m
//  CheatSheet
//
//  Created by Daniel Simons on 3/30/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "CSData.h"

@implementation CSData

@dynamic title;
@dynamic fullImage;
@dynamic screenshots;


- (id)initWithTitle:(NSString *)title fullImage:(NSData *)fullImage {
    if ((self = [super init])) {
        self.title = title;
        self.fullImage = fullImage;
    }
    return self;
}

@end

