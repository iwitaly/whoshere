//
//  IWUser.m
//  Who's here?
//
//  Created by Vitaly Davydov on 29/06/14.
//  Copyright (c) 2014 Vitaly Davydov. All rights reserved.
//

#import "IWUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation IWUser

@dynamic userId;
@dynamic status;

- (void)changeStatus {
    //TODO
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", self.userId, @(self.status)];
}

+ (NSString *)parseClassName {
    return @"IWUser";
}

@end
