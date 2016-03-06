#import "AOALocation.h"
#import "AOANote.h"
@import AddressBookUI;
@interface AOALocation ()

// Private interface goes here.

@end

@implementation AOALocation

+(instancetype) locationWithCLLocation: (CLLocation *) location
                               forNote: (AOANote *) note
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AOALocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"latitude = %f", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"longitude = %f", location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude,longitude]];
    
    NSError *error = nil;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req error:&error];
    
    NSAssert(results, @"Error al buscar location");
    
    if([results count]){
        AOALocation *found = [results lastObject];
        [found addNotesObject:note];
        return found;
    } else {
        AOALocation *loc = [self insertInManagedObjectContext: note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        
        [loc addNotesObject:note];
        
        CLGeocoder *coder = [CLGeocoder new];
        [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error while obtaining address!\n%@", error);
            } else {
                loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
            }
        }];
        return loc;
    }
}

@end
