#import "AOANotebook.h"

@interface AOANotebook ()

@end

@implementation AOANotebook

+(NSArray *) observableKeyNames{
    return @[@"creationDate", @"name", @"notes"];;
}

+(instancetype) notebookWithName:(NSString *) name context: (NSManagedObjectContext *) context{
    AOANotebook *nb = [NSEntityDescription insertNewObjectForEntityForName:[AOANotebook entityName] inManagedObjectContext:context];
    
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}


@end
