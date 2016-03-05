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

@end
