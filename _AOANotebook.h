// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOANotebook.h instead.

#import <CoreData/CoreData.h>
#import "AOANamedEntity.h"

extern const struct AOANotebookRelationships {
	__unsafe_unretained NSString *notes;
} AOANotebookRelationships;

@class AOANote;

@interface AOANotebookID : AOANamedEntityID {}
@end

@interface _AOANotebook : AOANamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOANotebookID* objectID;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _AOANotebook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(AOANote*)value_;
- (void)removeNotesObject:(AOANote*)value_;

@end

@interface _AOANotebook (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
