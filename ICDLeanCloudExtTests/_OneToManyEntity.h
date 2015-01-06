// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OneToManyEntity.h instead.

@import CoreData;

extern const struct OneToManyEntityAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *objectId;
} OneToManyEntityAttributes;

@interface OneToManyEntityID : NSManagedObjectID {}
@end

@interface _OneToManyEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) OneToManyEntityID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* objectId;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;

@end

@interface _OneToManyEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSString*)value;

@end
