//
//  PFQuery+userManagment.h
//  Who's here?
//
//  Created by Vitaly Davydov on 29/06/14.
//  Copyright (c) 2014 Vitaly Davydov. All rights reserved.
//

#import <Parse/Parse.h>
#import "IWUser.h"

@interface PFQuery (userManagment)

- (void)userWithUserId:(NSString *)userId withBlock:(PFObjectResultBlock)block;
- (void)onlineUsersWithBlock:(PFArrayResultBlock)block;

@end
