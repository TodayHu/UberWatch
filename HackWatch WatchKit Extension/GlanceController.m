//
//  GlanceController.m
//  HackWatch WatchKit Extension
//
//  Created by Sapan Bhuta on 11/23/14.
//  Copyright (c) 2014 SapanBhuta. All rights reserved.
//


#import "GlanceController.h"
#import "Model.h"

@interface GlanceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *textLabel;
@end


@implementation GlanceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        [self setup];
    }
    return self;
}

- (void)setup {
    NSLog(@"1");
    [Model currentLocationWithCompletionHandler:^(CLLocationCoordinate2D currentLocation) {
        NSLog(@"2 %.f %.f", currentLocation.latitude, currentLocation.longitude);

        [Model timeToLocation:currentLocation CompletionHandler:^(NSString *time, int seconds) {
            NSLog(@"3 %@", time);

            self.textLabel.text = [@" " stringByAppendingString:time];
        }];
    }];
}

@end