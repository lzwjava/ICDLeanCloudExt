// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DataTypeEntity.m instead.

#import "_DataTypeEntity.h"

const struct DataTypeEntityAttributes DataTypeEntityAttributes = {
	.array = @"array",
	.boolean = @"boolean",
	.data = @"data",
	.date = @"date",
	.dict = @"dict",
	.nullv = @"nullv",
	.number = @"number",
	.objectId = @"objectId",
	.string = @"string",
};

const struct DataTypeEntityRelationships DataTypeEntityRelationships = {
	.onetomany = @"onetomany",
	.onetoone = @"onetoone",
};

@implementation DataTypeEntityID
@end

@implementation _DataTypeEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DataTypeEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DataTypeEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DataTypeEntity" inManagedObjectContext:moc_];
}

- (DataTypeEntityID*)objectID {
	return (DataTypeEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"booleanValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"boolean"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic array;

@dynamic boolean;

- (BOOL)booleanValue {
	NSNumber *result = [self boolean];
	return [result boolValue];
}

- (void)setBooleanValue:(BOOL)value_ {
	[self setBoolean:@(value_)];
}

- (BOOL)primitiveBooleanValue {
	NSNumber *result = [self primitiveBoolean];
	return [result boolValue];
}

- (void)setPrimitiveBooleanValue:(BOOL)value_ {
	[self setPrimitiveBoolean:@(value_)];
}

@dynamic data;

@dynamic date;

@dynamic dict;

@dynamic nullv;

@dynamic number;

- (double)numberValue {
	NSNumber *result = [self number];
	return [result doubleValue];
}

- (void)setNumberValue:(double)value_ {
	[self setNumber:@(value_)];
}

- (double)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result doubleValue];
}

- (void)setPrimitiveNumberValue:(double)value_ {
	[self setPrimitiveNumber:@(value_)];
}

@dynamic objectId;

@dynamic string;

@dynamic onetomany;

- (NSMutableSet*)onetomanySet {
	[self willAccessValueForKey:@"onetomany"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"onetomany"];

	[self didAccessValueForKey:@"onetomany"];
	return result;
}

@dynamic onetoone;

@end

