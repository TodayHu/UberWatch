//
//  Model.m
//  HackWatch
//
//  Created by Sapan Bhuta on 11/23/14.
//  Copyright (c) 2014 SapanBhuta. All rights reserved.
//

#define kmylocation CLLocationCoordinate2DMake(39.134646, -84.503241)
#import "INTULocationManager.h"

#import "Model.h"

@implementation Model


+ (void)currentLocationWithCompletionHandler:(void (^)(CLLocationCoordinate2D currentLocation))handler {
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

+ (void)timeToLocation:(CLLocationCoordinate2D)location CompletionHandler:(void (^)(NSString *time, int seconds))handler {
    NSString *urlString = @"https://api.uber.com/v1/estimates/time?server_token=8d9zs_BC44E3pHgXpc5DW3IkUJ4znRlrsP8qLXHQ&start_latitude=39.134646&start_longitude=-84.503241";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *output = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        for (NSDictionary *option in output[@"times"]) {
            if ([option[@"display_name"] isEqualToString:@"uberX"]) {
                NSNumber *seconds = option[@"estimate"];
                handler([NSString stringWithFormat:@"%.d min", [seconds intValue]/60], [seconds intValue]);
            }
        }
    }];
}

@end
