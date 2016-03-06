//
//  AOANotebooksViewController.m
//  Everpobre
//
//  Created by Akixe on 1/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOANotebooksViewController.h"
#import "AOANotebook.h"
#import "AOANotebookCellView.h"
#import "AOANote.h"
#import "AOANotesViewController.h"

@interface AOANotebooksViewController ()

@end

@implementation AOANotebooksViewController

#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    self.title = @"Everpobre";
    
    //Crear un botón con un target y un action
    UIBarButtonItem *addbutton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addNotebook:)];
    
    //Lo añadimos a la navbar
    self.navigationItem.rightBarButtonItem = addbutton;
    
    // Ponemos el botón de edición
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    //Alta de notificación de sensor de proximidad
    UIDevice *device = [UIDevice currentDevice];
    
    if([self hasProximitySensor]){
        [device setProximityMonitoringEnabled:YES];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver: self selector:@selector(proximityStateDidChange:)
                       name: UIDeviceProximityStateDidChangeNotification
                     object: nil];
    }
    
    //Registrar el nib
    
    UINib *cellNib = [UINib nibWithNibName:@"AOANoteBookCellView" bundle:nil];
    
    [self.tableView registerNib:cellNib forCellReuseIdentifier:[AOANotebookCellView cellId]];
    //self.detailViewControllerClassName = NSStringFromClass([AOANotesViewController class]);
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}
#pragma mark - Actions

-(void) addNotebook:(id)sender{

    //Nueva instancia de AOANotebook
    [AOANotebook notebookWithName: @"New notebook"
                          context: self.fetchedResultsController.managedObjectContext];
}


#pragma mark - Data Source
-(void)     tableView:(UITableView *)tableView
   commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        AOANotebook *del = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:del];
    }
}
-(UITableViewCell *) tableView: (UITableView *) tableView
         cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    //Averiguar Notebook
    AOANotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear una celda
    AOANotebookCellView *cell = [tableView dequeueReusableCellWithIdentifier:[AOANotebookCellView cellId]];
    cell.nameView.text = nb.name;
    cell.numberOfNotesView.text = [NSString stringWithFormat: @"%lul", (unsigned long)[nb.notes count] ];
    return cell;
}

-(void)         tableView: (UITableView *)tableView
  didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    //crear fecthc request
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AOANote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:AOANamedEntityAttributes.name
                             ascending:YES],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AOANamedEntityAttributes.creationDate ascending:NO],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AOANamedEntityAttributes.modificationDate ascending:NO]];
    req.predicate = [NSPredicate predicateWithFormat:@"notebook = %@", [self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    NSFetchedResultsController *fC = [[NSFetchedResultsController alloc]
                                        initWithFetchRequest: req
                                        managedObjectContext: self.fetchedResultsController.managedObjectContext
                                        sectionNameKeyPath: nil
                                        cacheName: nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(140, 150);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10 , 10, 10, 10);
    
    AOANotesViewController *notesVC = [AOANotesViewController coreDataCollectionViewControllerWithFetchedResultsController:fC layout:layout];
    
    notesVC.notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:notesVC animated:YES];
}

#pragma mark - Proximity Sensor
-(BOOL) hasProximitySensor{
    //Esta es la forma de detectar si existe detección en sensor de proximidad o no
    //Se deve cambiar el valor existente y compararlo contra el original.
    //   Si cambia sí que hay detección en sensor de proximidad
    //   Si no hay cambio no había sensor
    UIDevice *device = [UIDevice currentDevice];
    BOOL oldValue = [device isProximityMonitoringEnabled];
    [device setProximityMonitoringEnabled:!oldValue];
    BOOL newValue = [device isProximityMonitoringEnabled];
    [device setProximityMonitoringEnabled:oldValue];
    return (oldValue != newValue);
}

-(void) proximityStateDidChange:(NSNotification *) notification{
   [self.fetchedResultsController.managedObjectContext.undoManager undo];
}


@end
