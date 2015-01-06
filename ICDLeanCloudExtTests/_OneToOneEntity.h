// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OneToOneEntity.h instead.

@import CoreData;

extern const struct OneToOneEntityAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *objectId;
} OneToOneEntityAttributes;

@interface OneToOneEntityID : NSManagedObjectID {}
@end

@interface _OneToOneEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) OneToOneEntityID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* objectId;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;

@end

@interface _OneToOneEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSString*)value;

@end
