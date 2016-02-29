#import "AOANotebook.h"

@interface AOANotebook ()

+(NSArray *) observableKeyNames;


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

#pragma mark  - KVO

- (void) setupKVO {
   
    for (NSString *key in [AOANotebook observableKeyNames]) {
        [self addObserver: self
               forKeyPath: key
                  options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context: NULL];
    }
}

-(void) tearDownKVO {
    for (NSString *key in [AOANotebook observableKeyNames]) {
        [self removeObserver:self
                  forKeyPath:key];
    }
}

- (void) observeValueForKeyPath: (NSString *) keyPath
                       ofObject: (id)object
                         change: (NSDictionary *) change
                        context: (void *) context{
    
    self.modificationDate = [NSDate date];
    
}

#pragma mark - Lifecycle
//Poner los observadores activos o mandarlos a T.P.C.
-(void) awakeFromInsert {
    //Siempre que se crea el objeto
    [super awakeFromInsert];
    [self setupKVO];
}

-(void) awakeFromFetch {
    //Siempre que se crea el objeto o vuelve de Fault
    [super awakeFromFetch];
    [self setupKVO];
}

-(void) willTurnIntoFault {
    //Se va a Fault
    [super willTurnIntoFault];
    [self tearDownKVO];
}
@end
