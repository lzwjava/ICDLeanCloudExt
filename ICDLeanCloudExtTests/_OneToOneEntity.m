// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OneToOneEntity.m instead.

#import "_OneToOneEntity.h"

const struct OneToOneEntityAttributes OneToOneEntityAttributes = {
	.name = @"name",
	.objectId = @"objectId",
};

@implementation OneToOneEntityID
@end

@implementation _OneToOneEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"OneToOneEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"OneToOneEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"OneToOneEntity" inManagedObjectContext:moc_];
}

- (OneToOneEntityID*)objectID {
	return (OneToOneEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic objectId;

@end

