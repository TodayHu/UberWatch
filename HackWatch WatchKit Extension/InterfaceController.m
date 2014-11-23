//
//  InterfaceController.m
//  HackWatch WatchKit Extension
//
//  Created by Sapan Bhuta on 11/23/14.
//  Copyright (c) 2014 SapanBhuta. All rights reserved.
//

#import "InterfaceController.h"
#import "Model.h"

@interface InterfaceController() <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet WKInterfaceButton *orderButton;
@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *timer;
@end


@implementation InterfaceController

- (IBAction)pressedLogo {
    NSLog(@"ordered an Uber");

    [Model currentLocationWithCompletionHandler:^(CLLocationCoordinate2D currentLocation) {
        [self.map setCoordinateRegion:MKCoordinateRegionMake(currentLocation, MKCoordinateSpanMake(.01, .01))];
        [self.map addAnnotation:currentLocation withPinColor:WKInterfaceMapPinColorGreen];
        self.orderButton.hidden = YES;
        self.map.hidden = NO;

        self.timer.hidden = NO;
        [Model timeToLocation:currentLocation CompletionHandler:^(NSString *time, int seconds) {
            [self.timer setDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
        }];
    }];
}
@end



