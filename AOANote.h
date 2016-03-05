#import "_AOANote.h"

@interface AOANote : _AOANote {}

@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) noteWithName: (NSString *) name
                    notebook: (AOANotebook *) notebook
                     context: (NSManagedObjectContext *) context;


@end
