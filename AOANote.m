#import "AOANote.h"

@interface AOANote ()

// Private interface goes here.

@end

@implementation AOANote

+(instancetype) noteWithName:(NSString *) name notebook:(AOANotebook *) notebook context: (NSManagedObjectContext *) context{
    AOANote *n = [NSEntityDescription insertNewObjectForEntityForName:[AOANote entityName] inManagedObjectContext:context];
    
    n.creationDate = [NSDate date];
    n.notebook = notebook;
    n.modificationDate = [NSDate date];
    
    return n;
}

@end
