#import "AOANamedEntity.h"

@interface AOANamedEntity ()

+(NSArray *) observableKeyNames;

@end

@implementation AOANamedEntity


#pragma mark - Class Methods

+(NSArray *) observableKeyNames{
    return @[@"creationDate", @"name"];
}

#pragma mark  - KVO

- (void) setupKVO {
    
    for (NSString *key in [[self class] observableKeyNames]) {
        [self addObserver: self
               forKeyPath: key
                  options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context: NULL];
    }
}

-(void) tearDownKVO {
    for (NSString *key in [[self class] observableKeyNames]) {
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
