#import "AOAMapSnapshot.h"
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
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001", location.coordinate.longitude];
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
        

        
        //DIRECCIÓN
        CLGeocoder *coder = [CLGeocoder new];
        [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error while obtaining address!\n%@", error);
            } else {
                loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
            }
        }];
        
        //Map Snapsho
        loc.mapSnapshot = [AOAMapSnapshot mapSnapshotForLocation:loc];
        
        return loc;
    }
}

@end
