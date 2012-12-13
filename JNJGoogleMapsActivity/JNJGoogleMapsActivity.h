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

#import <UIKit/UIKit.h>

extern const struct JNJGoogleMapsMapMode {
	__unsafe_unretained NSString *standard;
	__unsafe_unretained NSString *streetView;
} JNJGoogleMapsMapMode;

extern const struct JNJGoogleMapsViewType {
	__unsafe_unretained NSString *satellite;
	__unsafe_unretained NSString *traffic;
	__unsafe_unretained NSString *transit;
} JNJGoogleMapsViewType;

extern const struct JNJGoogleMapsDirectionMode {
	__unsafe_unretained NSString *driving;
	__unsafe_unretained NSString *transit;
	__unsafe_unretained NSString *walking;
} JNJGoogleMapsDirectionMode;

@interface JNJGoogleMapsActivity : UIActivity

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, assign) NSUInteger zoomLevel;
@property (nonatomic, copy) NSString *mapMode;
@property (nonatomic, copy) NSString *directionMode;

- (void)addViewType:(NSString *)viewtype;

@end
