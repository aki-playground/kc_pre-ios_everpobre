#import "_AOANote.h"

@interface AOANote : _AOANote {}


+(instancetype) noteWithName:(NSString *) name notebook:(AOANotebook *) notebook context: (NSManagedObjectContext *) context;
@end
