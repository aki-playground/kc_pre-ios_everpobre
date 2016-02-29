#import "_AOAPhoto.h"
@import UIKit;

@interface AOAPhoto : _AOAPhoto {}

@property (nonatomic, strong) UIImage * image;

+(instancetype) photoWithImage:(UIImage *) image context:(NSManagedObjectContext *) context;
@end
