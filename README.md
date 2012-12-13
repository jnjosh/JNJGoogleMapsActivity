# JNJGoogleMapsActivity #

A couple months ago, I gave a small talk at the [Raleigh, NC CocoaHeads](http://meetup.trianglecocoa.com) about UIActivity. I've been waiting for something to try making a quick activity with and tonight (12/12/12) at midnight (ok, technically 12/13/12) Google released their new Google Maps App for iOS. They also released some URL Schemes so I thought I'd through something quick together to try it out.

I'm not sure this is the best use of UIActivity but it was a fun little project, so __feedback is welcome__. I think in the future I might add a view controller to call that allows the developer to display a search field.

The map pin image mask was created with the very awesome [Pictos icons](http://pictos.cc/)

## Usage ##

    JNJGoogleMapsActivity *googleMapsActivity = [[JNJGoogleMapsActivity alloc] init];
    googleMapsActivity.latitude = @(35.7719);
    googleMapsActivity.longitude = @(-78.6389);
    googleMapsActivity.mapMode = JNJGoogleMapsMapMode.streetView;
    
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[] applicationActivities:@[googleMapsActivity]];
    [self presentViewController:viewController animated:YES completion:nil];

## Contact ##

[Josh Johnson](http://jnjosh.com) - [@jnjosh](http://twitter.com/jnjosh)

## License ##

MIT License, see more at: [http://jnjosh.mit-license.org](http://jnjosh.mit-license.org)