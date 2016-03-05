//
//  AOANotesViewController.m
//  Everpobre
//
//  Created by Akixe on 3/3/16.
//  Copyright © 2016 AOA. All rights reserved.
//

#import "AOANotesViewController.h"
#import "AOANote.h"
#import "AOANoteCellView.h"
#import "AOAPhoto.h"
#import "AOANoteViewController.h"

static NSString *cellId = @"NoteCellId";
@interface AOANotesViewController ()

@end

@implementation AOANotesViewController

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerNib];
    
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.title = @"Nota";
    
    UIBarButtonItem *new = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(createNewNote:)];
    self.navigationItem.rightBarButtonItem = new;
    self.detailViewControllerClassName = NSStringFromClass([AOANoteViewController class]);
}

#pragma mark - Xib registration
-(void) registerNib{
    UINib *nib = [UINib nibWithNibName:@"AOANoteCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
}
#pragma mark - Data Source

-(UICollectionViewCell*) collectionView: (UICollectionView *) collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //Obtener objeto
    AOANote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //Obtener una celda
    AOANoteCellView *cell = [collectionView
                             dequeueReusableCellWithReuseIdentifier: cellId
                             forIndexPath: indexPath];
    
    //Observamos cambios en AOANoteCellView.m
    [cell observeNote:note];
    return cell;
}

#pragma mark - Utils
-(void) createNewNote:(id) sender
{
    AOANoteViewController *newNoteVC = [[AOANoteViewController alloc] initForNewNoteInNotebook:self.notebook];
    [self.navigationController pushViewController:newNoteVC animated:YES];
}
#pragma mark - Delegate
/*
-(void)     collectionView: (UICollectionView *)collectionView
  didSelectItemAtIndexPath: (NSIndexPath *)indexPath
{
    AOANote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    AOANoteViewController *nVC = [[AOANoteViewController alloc] initWithModel:note];
    
    [self.navigationController pushViewController: nVC
                                         animated: YES];
}*/

@end
