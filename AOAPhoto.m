#import "AOAPhoto.h"

@interface AOAPhoto ()

// Private interface goes here.

@end

@implementation AOAPhoto

#pragma mark - Properties
-(void) setImage:(UIImage *) image{
    self.imageData = UIImagePNGRepresentation(image);
}

-(UIImage *) image {
    return [UIImage imageWithData:self.imageData];;
}

+(instancetype) photoWithImage: (UIImage *) image
                       context:(NSManagedObjectContext *) context{
    
    AOAPhoto *p = [NSEntityDescription insertNewObjectForEntityForName:[AOAPhoto entityName] inManagedObjectContext:context];
    p.imageData = UIImageJPEGRepresentation(image, 0.9);
    return p;
}


@end
