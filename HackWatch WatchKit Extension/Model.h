//
//  Model.h
//  HackWatch
//
//  Created by Sapan Bhuta on 11/23/14.
//  Copyright (c) 2014 SapanBhuta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
+ (void)currentLocationWithCompletionHandler:(void (^)(CLLocationCoordinate2D currentLocation))handler;
+ (void)timeToLocation:(CLLocationCoordinate2D)location CompletionHandler:(void (^)(NSString *time, int seconds))handler;
@end
