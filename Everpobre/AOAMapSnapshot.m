#import "AOAMapSnapshot.h"
#import "AOALocation.h"
@interface AOAMapSnapshot ()

// Private interface goes here.

@end

@implementation AOAMapSnapshot
// Custom logic goes here.





#pragma mark - properties
-(UIImage *) image
{
    return [UIImage imageWithData:self.snapshotData];
}

-(void) setImage:(UIImage *)image
{
    self.snapshotData = UIImageJPEGRepresentation(image, 0.9);
}


#pragma mark - Class Names
+(instancetype) mapSnapshotForLocation: (AOALocation *) location
{
    AOAMapSnapshot *snap = [AOAMapSnapshot insertInManagedObjectContext:location.managedObjectContext];
    
    snap.location = location;
    
    return  snap;
}



-(void) awakeFromInsert
{
    [super awakeFromInsert];
    [self startObserving];
}

-(void) awakeFromFetch
{
    [super awakeFromFetch];
    [self startObserving];
}

-(void) willTurnIntoFault
{
    [super willTurnIntoFault];
    [self stopObserving];
}

#pragma mark - KVO

-(void) startObserving
{
    [self addObserver:self
           forKeyPath:@"location"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

-(void) stopObserving
{
    [self removeObserver: self
              forKeyPath: @"location"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.location.latitudeValue, self.location.longitudeValue);
    
    
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    options.region = MKCoordinateRegionMakeWithDistance(center, 300, 300);
    options.mapType = MKMapTypeHybrid;
    options.size = CGSizeMake(150, 150);
    
    MKMapSnapshotter *shotter =[[MKMapSnapshotter alloc] initWithOptions:options];
    [shotter startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if(!error){
            self.image = snapshot.image;
        } else {
            [self setPrimitiveLocation:nil];
            [self.managedObjectContext deleteObject:self];
        }
    }];
    
    
    
}
@end
