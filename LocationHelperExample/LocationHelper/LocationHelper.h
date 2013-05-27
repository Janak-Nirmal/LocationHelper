//
//  LocationController.h
//  LocationHelperExample
//
//  Created by Jennis on 05/27/13.
//  Copyright 2013 Jennis. All rights reserved.
//  See the file License.txt for copying permission.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kAuthorizationUpdateNotification @"JNAuthorizationUpdateNotification"
#define kLocationUpdateNotification @"JNLocationUpdateNotification"

@interface LocationHelper : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, assign) BOOL locationDenied;

+ (LocationHelper *)sharedInstance;
- (void) requestNewLocation;

@end
