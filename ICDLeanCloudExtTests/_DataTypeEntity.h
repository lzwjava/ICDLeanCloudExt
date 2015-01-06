// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DataTypeEntity.h instead.

@import CoreData;

extern const struct DataTypeEntityAttributes {
	__unsafe_unretained NSString *array;
	__unsafe_unretained NSString *boolean;
	__unsafe_unretained NSString *data;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *dict;
	__unsafe_unretained NSString *nullv;
	__unsafe_unretained NSString *number;
	__unsafe_unretained NSString *objectId;
	__unsafe_unretained NSString *string;
} DataTypeEntityAttributes;

extern const struct DataTypeEntityRelationships {
	__unsafe_unretained NSString *onetomany;
	__unsafe_unretained NSString *onetoone;
} DataTypeEntityRelationships;

@class OneToManyEntity;
@class OneToOneEntity;

@class NSObject;

@class NSObject;

@interface DataTypeEntityID : NSManagedObjectID {}
@end

@interface _DataTypeEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DataTypeEntityID* objectID;

@property (nonatomic, strong) id array;

//- (BOOL)validateArray:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* boolean;

@property (atomic) BOOL booleanValue;
- (BOOL)booleanValue;
- (void)setBooleanValue:(BOOL)value_;

//- (BOOL)validateBoolean:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* data;

//- (BOOL)validateData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id dict;

//- (BOOL)validateDict:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* nullv;

//- (BOOL)validateNullv:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* number;

@property (atomic) double numberValue;
- (double)numberValue;
- (void)setNumberValue:(double)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* objectId;

//- (BOOL)validateObjectId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* string;

//- (BOOL)validateString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *onetomany;

- (NSMutableSet*)onetomanySet;

@property (nonatomic, strong) OneToOneEntity *onetoone;

//- (BOOL)validateOnetoone:(id*)value_ error:(NSError**)error_;

@end

@interface _DataTypeEntity (OnetomanyCoreDataGeneratedAccessors)
- (void)addOnetomany:(NSSet*)value_;
- (void)removeOnetomany:(NSSet*)value_;
- (void)addOnetomanyObject:(OneToManyEntity*)value_;
- (void)removeOnetomanyObject:(OneToManyEntity*)value_;

@end

@interface _DataTypeEntity (CoreDataGeneratedPrimitiveAccessors)

- (id)primitiveArray;
- (void)setPrimitiveArray:(id)value;

- (NSNumber*)primitiveBoolean;
- (void)setPrimitiveBoolean:(NSNumber*)value;

- (BOOL)primitiveBooleanValue;
- (void)setPrimitiveBooleanValue:(BOOL)value_;

- (NSData*)primitiveData;
- (void)setPrimitiveData:(NSData*)value;

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (id)primitiveDict;
- (void)setPrimitiveDict:(id)value;

- (NSString*)primitiveNullv;
- (void)setPrimitiveNullv:(NSString*)value;

- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (double)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(double)value_;

- (NSString*)primitiveObjectId;
- (void)setPrimitiveObjectId:(NSString*)value;

- (NSString*)primitiveString;
- (void)setPrimitiveString:(NSString*)value;

- (NSMutableSet*)primitiveOnetomany;
- (void)setPrimitiveOnetomany:(NSMutableSet*)value;

- (OneToOneEntity*)primitiveOnetoone;
- (void)setPrimitiveOnetoone:(OneToOneEntity*)value;

@end
