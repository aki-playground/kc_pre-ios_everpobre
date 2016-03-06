// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOAMapSnapshot.m instead.

#import "_AOAMapSnapshot.h"

const struct AOAMapSnapshotAttributes AOAMapSnapshotAttributes = {
	.snapshotData = @"snapshotData",
};

const struct AOAMapSnapshotRelationships AOAMapSnapshotRelationships = {
	.location = @"location",
};

@implementation AOAMapSnapshotID
@end

@implementation _AOAMapSnapshot

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MapSnapshot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

- (AOAMapSnapshotID*)objectID {
	return (AOAMapSnapshotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic snapshotData;

@dynamic location;

@end

