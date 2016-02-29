// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOANote.h instead.

#import <CoreData/CoreData.h>
#import "AOANamedEntity.h"

extern const struct AOANoteAttributes {
	__unsafe_unretained NSString *text;
} AOANoteAttributes;

extern const struct AOANoteRelationships {
	__unsafe_unretained NSString *notebook;
	__unsafe_unretained NSString *photo;
} AOANoteRelationships;

@class AOANotebook;
@class AOAPhoto;

@interface AOANoteID : AOANamedEntityID {}
@end

@interface _AOANote : AOANamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOANoteID* objectID;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOANotebook *notebook;

//- (BOOL)validateNotebook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOAPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _AOANote (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (AOANotebook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(AOANotebook*)value;

- (AOAPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(AOAPhoto*)value;

@end
