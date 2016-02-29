// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOAPhoto.m instead.

#import "_AOAPhoto.h"

const struct AOAPhotoAttributes AOAPhotoAttributes = {
	.imageData = @"imageData",
};

const struct AOAPhotoRelationships AOAPhotoRelationships = {
	.notes = @"notes",
};

@implementation AOAPhotoID
@end

@implementation _AOAPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (AOAPhotoID*)objectID {
	return (AOAPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic notes;

@end

