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
@dynamic doc;


- (id)initWithTitle:(NSString *)title doc:(CSDoc *)doc {
    if ((self = [super init])) {
        self.title = title;
        self.doc = doc;
    }
    return self;
}

@end
