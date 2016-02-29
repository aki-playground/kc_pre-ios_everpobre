// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AOANote.m instead.

#import "_AOANote.h"

const struct AOANoteAttributes AOANoteAttributes = {
	.text = @"text",
};

const struct AOANoteRelationships AOANoteRelationships = {
	.notebook = @"notebook",
	.photo = @"photo",
};

@implementation AOANoteID
@end

@implementation _AOANote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (AOANoteID*)objectID {
	return (AOANoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic text;

@dynamic notebook;

@dynamic photo;

@end

