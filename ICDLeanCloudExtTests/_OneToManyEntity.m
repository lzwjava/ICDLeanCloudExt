// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OneToManyEntity.m instead.

#import "_OneToManyEntity.h"

const struct OneToManyEntityAttributes OneToManyEntityAttributes = {
	.name = @"name",
	.objectId = @"objectId",
};

@implementation OneToManyEntityID
@end

@implementation _OneToManyEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"OneToManyEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"OneToManyEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"OneToManyEntity" inManagedObjectContext:moc_];
}

- (OneToManyEntityID*)objectID {
	return (OneToManyEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic objectId;

@end

