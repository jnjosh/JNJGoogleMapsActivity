//
//  JNJMapSampleViewController.m
//  JNJGoogleMapsActivity-Sample
//
//  Created by Josh Johnson on 12/13/12.
//  Copyright (c) 2012 jnjosh.com. All rights reserved.
//

#import "JNJMapSampleViewController.h"
#import "JNJGoogleMapsActivity.h"

@interface JNJMapSampleViewController ()

@end

@implementation JNJMapSampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)openGoogleMaps:(id)sender
{
	// Open Google Maps with no information
	
	JNJGoogleMapsActivity *googleMapsActivity = [[JNJGoogleMapsActivity alloc] init];
	
	UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[]	applicationActivities:@[googleMapsActivity]];
	[self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)openGoogleMapsForPizza:(id)sender
{
	// Open Google Maps and Search For Pizza in Raleigh, NC
	
	JNJGoogleMapsActivity *googleMapsActivity = [[JNJGoogleMapsActivity alloc] init];
	googleMapsActivity.latitude = @(35.7719);
	googleMapsActivity.longitude = @(-78.6389);
	
	UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Pizza"]	applicationActivities:@[googleMapsActivity]];
	[self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)openGoogleMapsForDirections:(id)sender
{
	// Open Google Maps App and get directions from Durham to Raleigh
	
	JNJGoogleMapsActivity *googleMapsActivity = [[JNJGoogleMapsActivity alloc] init];
	googleMapsActivity.directionMode = JNJGoogleMapsDirectionMode.driving;
	googleMapsActivity.mapMode = JNJGoogleMapsMapMode.standard;
	
	UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"320 E. Chapel Hill Street Durham, NC 27613", @"439 Glenwood Avenue Raleigh, NC 27603"] applicationActivities:@[googleMapsActivity]];
	[self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)openGoogleMapsAtLocation:(id)sender
{
	// Open Google Maps at Raleigh, NC in street mode
	
	JNJGoogleMapsActivity *googleMapsActivity = [[JNJGoogleMapsActivity alloc] init];
	googleMapsActivity.latitude = @(35.7719);
	googleMapsActivity.longitude = @(-78.6389);
	googleMapsActivity.mapMode = JNJGoogleMapsMapMode.streetView;
	
	UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[] applicationActivities:@[googleMapsActivity]];
	[self presentViewController:viewController animated:YES completion:nil];
}

@end
