//
//  IWUser.h
//  Who's here?
//
//  Created by Vitaly Davydov on 29/06/14.
//  Copyright (c) 2014 Vitaly Davydov. All rights reserved.
//

#import <Parse/Parse.h>

typedef enum IWUserStatus : NSUInteger {
    IWUserStatusOffline,
    IWUserStatusOnline
}IWUserStatus;

@interface IWUser : PFObject<PFSubclassing>

//user's data
@property (nonatomic, strong) NSString *userId;
@property (nonatomic) IWUserStatus status;

//change user's status on the cloud
- (void)changeStatus;

@end
