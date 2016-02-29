// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOAPhoto.h instead.

#import <CoreData/CoreData.h>

extern const struct AOAPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} AOAPhotoAttributes;

extern const struct AOAPhotoRelationships {
	__unsafe_unretained NSString *notes;
} AOAPhotoRelationships;

@class AOANote;

@interface AOAPhotoID : NSManagedObjectID {}
@end

@interface _AOAPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOAPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOANote *notes;

//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;

@end

@interface _AOAPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (AOANote*)primitiveNotes;
- (void)setPrimitiveNotes:(AOANote*)value;

@end
