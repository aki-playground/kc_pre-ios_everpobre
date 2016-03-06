#import "_AOAMapSnapshot.h"

@interface AOAMapSnapshot : _AOAMapSnapshot {}
// Custom logic goes here.

@property (strong, nonatomic) UIImage *image;

+(instancetype) mapSnapshotForLocation: (AOALocation *) location;

@end
