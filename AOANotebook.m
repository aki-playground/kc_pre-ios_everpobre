#import "AOANotebook.h"

@interface AOANotebook ()

// Private interface goes here.

@end

@implementation AOANotebook

// Custom logic goes here.

+(instancetype) notebookWithName:(NSString *) name context: (NSManagedObjectContext *) context{
    AOANotebook *nb = [NSEntityDescription insertNewObjectForEntityForName:[AOANotebook entityName] inManagedObjectContext:context];
    
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}

@end
