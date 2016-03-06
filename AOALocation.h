#import "_AOALocation.h"

@import CoreLocation;
@class AOANote;

@interface AOALocation : _AOALocation {}
// Custom logic goes here.

+(instancetype) locationWithCLLocation: (CLLocation *) location
                               forNote: (AOANote *) note;
@end
