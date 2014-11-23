//
//  ViewController.m
//  HackWatch
//
//  Created by Sapan Bhuta on 11/23/14.
//  Copyright (c) 2014 SapanBhuta. All rights reserved.
//

#define kmylocation CLLocationCoordinate2DMake(39.134646, -84.503241)

#import "ViewController.h"
#import "INTULocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self currentLocationWithCompletionHandler:^(CLLocationCoordinate2D currentLocation) {

    }];
}

- (void)currentLocationWithCompletionHandler:(void (^)(CLLocationCoordinate2D currentLocation))handler {
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse timeout:30.0 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            NSLog(@"INTULocationManager SUCCESS");
            handler(currentLocation.coordinate);
        }
        else if (status == INTULocationStatusTimedOut) {
            NSLog(@"INTULocationManager TIMEOUT");
            handler(kmylocation);
        }
        else {
            NSLog(@"INTULocationManager FAILED");
            handler(kmylocation);
        }
    }];
}

@end
