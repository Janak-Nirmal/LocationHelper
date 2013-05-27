//
//  LocationController.m
//  LocationHelperExample
//
//  Created by Jennis on 05/27/13.
//  Copyright 2013 Jennis. All rights reserved.
//  See the file License.txt for copying permission.
//

#import "LocationHelper.h"

@implementation LocationHelper

static LocationHelper *sharedLocationHelper = nil;

+ (LocationHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationHelper = [[LocationHelper alloc] init];
    });
    return sharedLocationHelper;
}

-(id)init
{
 	self = [super init];
	if (self != nil) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = 10.0f;
        //[_locationManager startUpdatingLocation];
	}
	return self;
}

-(void)requestNewLocation
{
    if([self isAuthorized]){
        [_locationManager startUpdatingLocation];
        return;
    }
    else{
        _locationDenied = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kAuthorizationUpdateNotification object:@NO userInfo:nil];        
    }
}

#pragma mark -
#pragma mark CLLocationManager Delegate Methods

- (void)locationManager:(CLLocationManager*)manager	didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation{
    _currentLocation = newLocation;
    [_locationManager stopUpdatingLocation];
    [manager stopUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdateNotification object:_currentLocation userInfo:nil];
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
	if([error code]== kCLErrorDenied){
        _locationDenied = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kAuthorizationUpdateNotification object:@NO userInfo:nil];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdateNotification object:error userInfo:nil];
}

#pragma mark -
#pragma mark Authorization methods


-(BOOL)isAuthorized
{
    BOOL authorizationStatus = NO;
    if (![CLLocationManager locationServicesEnabled]){
        return authorizationStatus;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return authorizationStatus;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        authorizationStatus = YES;
        return authorizationStatus;
    }
    
    return authorizationStatus;
}

@end
