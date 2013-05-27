//
//  ViewController.m
//  LocationHelperExample
//
//  Created by Jennis on 27/05/13.
//  Copyright (c) 2013 MFMA. All rights reserved.
//

#import "ViewController.h"
#import "LocationHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationAuthorizationStatus:) name:kAuthorizationUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated:) name:kLocationUpdateNotification object:nil];
    [[LocationHelper sharedInstance] requestNewLocation];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAuthorizationUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLocationUpdateNotification object:nil];    
}

-(void)locationAuthorizationStatus:(NSNotification*)authorizationStatus
{
    NSNumber *granted = authorizationStatus.object;
    if(!granted.boolValue)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Access Location" message:@"Please enable access in Settings > Privacy > Location." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
}

-(void)locationUpdated:(NSNotification*)locationUpdateNotification
{
    if(![locationUpdateNotification.object isKindOfClass:[NSError class]])
    {
        CLLocation *newLocation = (CLLocation*)locationUpdateNotification.object;
        NSLog(@"Location updated-->%f, %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    }
    else
    {
        NSError *error = locationUpdateNotification.object;
        NSLog(@"Location failed for reason %@",error.localizedDescription);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
