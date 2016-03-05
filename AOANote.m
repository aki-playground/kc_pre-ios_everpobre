#import "AOANote.h"

@interface AOANote ()

@end

@implementation AOANote


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

@end
