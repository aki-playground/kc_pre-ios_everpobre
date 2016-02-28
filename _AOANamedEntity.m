// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOANamedEntity.m instead.

#import "_AOANamedEntity.h"

const struct AOANamedEntityAttributes AOANamedEntityAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
};

@implementation AOANamedEntityID
@end

@implementation _AOANamedEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NamedEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

- (AOANamedEntityID*)objectID {
	return (AOANamedEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@end

