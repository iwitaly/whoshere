//
//  IWTableViewController.m
//  Who's here?
//
//  Created by Vitaly Davydov on 29/06/14.
//  Copyright (c) 2014 Vitaly Davydov. All rights reserved.
//

#import "IWTableViewController.h"
#import "PFQuery+userManagment.h"

#define UIID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@interface IWTableViewController ()

@property (nonatomic, strong) IWUser *user;

@end

@implementation IWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCurrentUser];
    // The className to query on
    self.parseClassName = @"IWUser";
    // The key of the PFObject to display in the label of the default cell style
    self.textKey = @"userId";
    // The title for this table in the Navigation Controller.
    self.title = @"Online";
    // Whether the built-in pagination is enabled
    self.paginationEnabled = NO;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [IWUser query];
    [query whereKey:@"status" equalTo:@(IWUserStatusOnline)];
    return query;
}

- (void)initCurrentUser {
    if (!self.user) {
        PFQuery *query = [IWUser query];
        [query userWithUserId:UIID withBlock:^(PFObject *object, NSError *error) {
            if (!object) {//if user not exists on server
                _user = [IWUser object];
                _user.userId = UIID;
                _user.status = IWUserStatusOffline;
                [self.user saveInBackground];
            } else {
                self.user = (IWUser *)object;
            }
        }];
    }
}

- (IBAction)askToChangeStatus {
    if (self.user && self.user.status == IWUserStatusOffline) {
        self.user.status = IWUserStatusOnline;
        [NSTimer scheduledTimerWithTimeInterval:3600
                                         target:self
                                       selector:@selector(deprecateStatus)
                                       userInfo:nil
                                        repeats:NO];
        
        [self.user saveInBackground];
    } else {
        NSLog(@"user hasn't been initialised yet or user's status is already online");
    }
}

//change user's status to offline when timer fired
- (void)deprecateStatus {
    if (self.user && self.user.status == IWUserStatusOnline) {
        self.user.status = IWUserStatusOffline;
        [self.user saveInBackground];
        
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:@"timerFires"];
        [push setMessage:@"Timer fires, you were moved to offlime status"];
        [push sendPushInBackground];
    }
}

@end
