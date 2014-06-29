//
//  PFQuery+userManagment.m
//  Who's here?
//
//  Created by Vitaly Davydov on 29/06/14.
//  Copyright (c) 2014 Vitaly Davydov. All rights reserved.
//

#import "PFQuery+userManagment.h"

@implementation PFQuery (userManagment)

- (void)userWithUserId:(NSString *)userId withBlock:(PFObjectResultBlock)block {
    [self whereKey:@"userId" equalTo:userId];
    [self getFirstObjectInBackgroundWithBlock:block];
}

- (void)onlineUsersWithBlock:(PFArrayResultBlock)block {
    [self whereKey:@"status" equalTo:@(IWUserStatusOnline)];
    [self findObjectsInBackgroundWithBlock:block];
}

@end
