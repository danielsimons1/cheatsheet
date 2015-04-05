//
//  CSScreenshot.m
//  CheatSheet
//
//  Created by Daniel Simons on 4/3/15.
//  Copyright (c) 2015 UnofficialCalculators. All rights reserved.
//

#import "CSScreenshot.h"
#import "CSData.h"


@implementation CSScreenshot

@dynamic imageData;
@dynamic data;
@dynamic scale;
@dynamic translationX;
@dynamic translationY;

- (id)initWithImageData:(NSData *)imageData {
    if ((self = [super init])) {
        self.imageData = imageData;
    }
    return self;
}

@end
