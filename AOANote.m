#import "AOANote.h"

@interface AOANote ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation AOANote <CLLocationManagerDelegate>

@synthesize locationManager = _locationManager;

-(BOOL) hasLocation
{
    return (nil == self.location);
}

+(NSArray *) observableKeyNames{
    return @[@"creationDate", @"name", @"notebook", @"photo"];
}

+(instancetype) noteWithName:(NSString *) name notebook:(AOANotebook *) notebook context: (NSManagedObjectContext *) context{
    AOANote *n = [NSEntityDescription insertNewObjectForEntityForName:[AOANote entityName] inManagedObjectContext:context];
    
    n.creationDate = [NSDate date];
    n.notebook = notebook;
    n.modificationDate = [NSDate date];
    n.name = name;
    
    return n;
}

#pragma mark - Init
-(void) awakeFromInsert
{
    [super awakeFromInsert];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (((status == kCLAuthorizationStatusAuthorizedAlways) || (status == kCLAuthorizationStatusNotDetermined)) && [CLLocationManager locationServicesEnabled]){
        //Tenemos localización
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingHeading];
    }
}


#pragma mark - CLLocationManagerDelegate
-(void)     locationManager: (CLLocationManager *) manager
         didUpdateLocations: (nonnull NSArray<CLLocation *> *)locations
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil; //si no lo hacemos seguiría pidiendo la localización a pesar del Stop
    CLLocation *location = [locations lastObject];
    
    self.location = [AOALocation locationWithCLLocation: locations forNote: self];
    
    
}
@end
