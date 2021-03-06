//
//  AppDelegate.m
//  Everpobre
//
//  Created by Akixe on 28/2/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTSimpleCoreDataStack.h"
#import "AOANotebooksViewController.h"
#import "AOANote.h"
#import "AOANotebook.h"
#import "AOALocation.h"
#import "UIViewController+Navigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    // ¿Añadimos datos chorras?
    
    if (ADD_DUMMY_DATA) {
        [self addDummyData];
        
    }
    
    
    // Iniciamos el inspector del contexto
    [self printContextState];

    
    
    [self autoSave];
    //Recuperar las libretas
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AOANotebook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:AOANamedEntityAttributes.modificationDate
                             ascending:NO],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AOANamedEntityAttributes.name
                             ascending:YES]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc]
                                           initWithFetchRequest:req
                                           managedObjectContext:self.model.context
                                           sectionNameKeyPath:nil
                                           cacheName:nil];
    
    AOANotebooksViewController *nbVC = [[AOANotebooksViewController alloc]
                                        initWithFetchedResultsController:results
                                        style:UITableViewStylePlain];
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [nbVC wreappedInNavigation];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //Es buen momento para guardar datos
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils

- (void) trastearConDatos{
    AOANotebook *novias = [AOANotebook notebookWithName:@"Ex-novias" context:self.model.context];
    
    [AOANote noteWithName: @"Camila"
                 notebook: novias
                  context: self.model.context];
    [AOANote noteWithName: @"Pampita"
                 notebook: novias
                  context: self.model.context];
    
    //Búsquedas
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[AOANote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AOANamedEntityAttributes.name ascending:YES],
                            [NSSortDescriptor sortDescriptorWithKey:AOANamedEntityAttributes.modificationDate ascending:NO]];
    
    NSError *error = nil;
    NSArray *results = [self.model.context executeFetchRequest:req error:&error];
    
    if(results == nil){
        NSLog(@"Error al buscar %@", results);
    } else {
        NSLog(@"Results %@", results);
    }
    [self save];
}

-(void) save {
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error); //__func__ lo entiende el compilador y te da el nombre de la función
    }];
}

-(void) autoSave {
    if (AUTO_SAVE){
        NSLog(@"Autosaving...");
        
        [self save];
        
        [self performSelector: @selector(autoSave)
                   withObject: nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
    }
}

-(void) printContextState
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AOANotebook entityName]];
    NSUInteger numNotebooks = [[self.model executeRequest:req withError:nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName:[AOANote entityName]];
    NSUInteger numNotes = [[self.model executeRequest:req withError:nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName:[AOALocation entityName]];
    NSUInteger numLocations = [[self.model executeRequest:req withError:nil] count];
    
    printf("================================================");
    printf("Total number of objects:      %lu\n", (unsigned long)self.model.context.registeredObjects.count);
    printf("Number of notebooks:          %lu\n", (unsigned long)numNotebooks);
    printf("Number of notes:              %lu\n", (unsigned long)numNotes);
    printf("Number of locations:          %lu\n", (unsigned long)numLocations);
    printf("================================================");
    
    [self performSelector: @selector(printContextState)
               withObject: nil
               afterDelay: 5];
}


-(void) addDummyData
{
    [self.model zapAllData];
    
    AOANotebook *familiaNB = [AOANotebook notebookWithName: @"Familia"
                                                   context: self.model.context];
    
    [AOANote noteWithName:@"Akixe"
                 notebook:familiaNB
                  context:self.model.context];
    
    [AOANote noteWithName:@"Ixiar"
                 notebook:familiaNB
                  context:self.model.context];
    
    [AOANote noteWithName:@"Laira"
                 notebook:familiaNB
                  context:self.model.context];
    
    [AOANote noteWithName:@"Jare"
                 notebook:familiaNB
                  context:self.model.context];
    
    AOANotebook *lugaresNB = [AOANotebook notebookWithName: @"Lugares donde han pasado frikadas"
                                                   context: self.model.context];
    
    

    [AOANote noteWithName:@"Area 51"
                 notebook:lugaresNB
                  context:self.model.context];
    [AOANote noteWithName:@"Plató de Cuarto Milenio: Friker Jiménez Land"
                 notebook:lugaresNB
                  context:self.model.context];
    [AOANote noteWithName:@"Triángulo de las Bermudas"
                 notebook:lugaresNB
                  context:self.model.context];
    [AOANote noteWithName:@"Plató de Sálvame:Hard Frikerio"
                 notebook:lugaresNB
                  context:self.model.context];

    [self save];
}
@end

