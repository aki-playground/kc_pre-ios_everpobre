// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOAMapSnapshot.h instead.

#import <CoreData/CoreData.h>

extern const struct AOAMapSnapshotAttributes {
	__unsafe_unretained NSString *snapshotData;
} AOAMapSnapshotAttributes;

extern const struct AOAMapSnapshotRelationships {
	__unsafe_unretained NSString *location;
} AOAMapSnapshotRelationships;

@class AOALocation;

@interface AOAMapSnapshotID : NSManagedObjectID {}
@end

@interface _AOAMapSnapshot : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AOAMapSnapshotID* objectID;

@property (nonatomic, strong) NSData* snapshotData;

//- (BOOL)validateSnapshotData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AOALocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _AOAMapSnapshot (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveSnapshotData;
- (void)setPrimitiveSnapshotData:(NSData*)value;

- (AOALocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AOALocation*)value;

@end
