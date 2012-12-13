//
//  JNJGoogleMapsActivity
//
//  Copyright © 2012 Josh Johnson <jnjosh@jnjosh.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the “Software”),
//  to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "JNJGoogleMapsActivity.h"

NSString * const kJNJActivityTypeOpenInGoogleMaps = @"JNJActivityTypeOpenInGoogleMaps";
NSString * const kJNJGoogleMapsActivityTitle = @"Open in Google Maps";
NSString * const kJNJGoogleMapsActivityMaskImageName = @"JNJGoogleMapsActivityMask";

NSString * const kJNJGoogleMapsURLSchemeString = @"comgooglemaps://";
NSString * const kJNJGoogleMapsQueryKeyZoom = @"zoom";
NSString * const kJNJGoogleMapsQueryKeyCenter = @"center";
NSString * const kJNJGoogleMapsQueryKeyMapMode = @"mapmode";
NSString * const kJNJGoogleMapsQueryKeyViews = @"views";
NSString * const kJNJGoogleMapsQueryKeyQuery = @"q";
NSString * const kJNJGoogleMapsQueryKeyStartAddress = @"saddr";
NSString * const kJNJGoogleMapsQueryKeyDestinationAddress = @"daddr";
NSString * const kJNJGoogleMapsQueryKeyDirectionMode = @"directionsmode";

const struct JNJGoogleMapsMapMode JNJGoogleMapsMapMode = {
	.standard = @"standard",
	.streetView = @"streetview"
};

const struct JNJGoogleMapsViewType JNJGoogleMapsViewType = {
	.satellite = @"satellite",
	.traffic = @"traffic",
	.transit = @"transit"
};

const struct JNJGoogleMapsDirectionMode JNJGoogleMapsDirectionMode = {
	.driving = @"driving",
	.transit = @"transit",
	.walking = @"walking"
};

@interface JNJGoogleMapsActivity ()

@property (nonatomic, copy) NSString *queryString;

@property (nonatomic, copy) NSString *startAddress;
@property (nonatomic, copy) NSString *destinationAddress;

@property (nonatomic, strong) NSMutableArray *viewTypes;

+ (BOOL)canOpenGoogleMapsURLScheme:(NSURL *)url;
- (NSString *)parameterStringWithKey:(NSString *)key value:(NSString *)value;

@end

@implementation JNJGoogleMapsActivity

#pragma mark - NSObject

- (id)init
{
	if (self = [super init]) {
		_viewTypes = [NSMutableArray array];
	}
	return self;
}

#pragma mark - JNJGoogleMapsActivity

- (void)addViewType:(NSString *)viewtype
{
	[self.viewTypes addObject:[viewtype copy]];
}

- (NSString *)parameterStringWithKey:(NSString *)key value:(NSString *)value
{
	return [NSString stringWithFormat:@"%@=%@", key, value];
}

+ (BOOL)canOpenGoogleMapsURLScheme:(NSURL *)url
{
	return [[UIApplication sharedApplication] canOpenURL:url];
}

#pragma mark - UIActivity

- (NSString *)activityType
{
	return kJNJActivityTypeOpenInGoogleMaps;
}

- (NSString *)activityTitle
{
	return kJNJGoogleMapsActivityTitle;
}

- (UIImage *)activityImage
{
	return [UIImage imageNamed:kJNJGoogleMapsActivityMaskImageName];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	// TODO: Probably should make sure it is a string
	if ([activityItems count] > 1) {
		self.startAddress = [activityItems objectAtIndex:0];
		self.destinationAddress = [activityItems objectAtIndex:1];
	} else if ([activityItems count] == 1) {
		self.queryString = [activityItems lastObject];
	}
	
	return [[self class] canOpenGoogleMapsURLScheme:[NSURL URLWithString:kJNJGoogleMapsURLSchemeString]];
}

- (void)performActivity
{
	BOOL didFinish = NO;
	
	NSMutableString *googleMapsURLString = [NSMutableString stringWithFormat:@"%@?", kJNJGoogleMapsURLSchemeString];
	NSMutableArray *components = [NSMutableArray array];
	
	if (self.queryString) {
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyQuery value:self.queryString]];
	}
	
	if (self.startAddress && self.destinationAddress) {
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyStartAddress value:self.startAddress]];
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyDestinationAddress value:self.destinationAddress]];
	}

	if (self.latitude && self.longitude) {
		NSString *position = [NSString stringWithFormat:@"%@,%@", [self.latitude stringValue], [self.longitude stringValue]];
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyCenter value:position]];
	}

	if (self.zoomLevel > 0) {
		NSString *zoomLevel = [NSString stringWithFormat:@"%i", self.zoomLevel];
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyZoom value:zoomLevel]];
	}
	
	if (self.mapMode) {
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyMapMode value:self.mapMode]];
	}
	
	if (self.directionMode) {
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyDirectionMode value:self.directionMode]];
	}
	
	if ([self.viewTypes count] > 0) {
		NSString *viewTypes = [self.viewTypes componentsJoinedByString:@","];
		[components addObject:[self parameterStringWithKey:kJNJGoogleMapsQueryKeyViews value:viewTypes]];
	}
	
	NSString *componentsString = [components componentsJoinedByString:@"&"];
    if ([componentsString length] > 0) {
        [googleMapsURLString appendFormat:@"&%@", componentsString];
    }
	
	NSURL *googleMapsURL = [NSURL URLWithString:[googleMapsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[self class] canOpenGoogleMapsURLScheme:googleMapsURL]) {
        [[UIApplication sharedApplication] openURL:googleMapsURL];
        didFinish = YES;
    }

    [self activityDidFinish:didFinish];
}

@end
