//
//  AVObject+CoreData.h
//  ICDLeanCloudExt
//
//  Created by LEI on 1/3/15.
//  Copyright (c) 2015 TouchingApp. All rights reserved.
//
#import <AVObject.h>
#import <AVRelation.h>
#define MR_SHORTHAND 1
#import <MagicalRecord/MagicalRecord.h>


@interface AVObject (CoreData)

+ (NSDictionary *)managedObjectKeysByPropertyKey;

+ (NSDictionary *)managedRelationshipClassesByPropertyKey;

+ (NSSet *)managedObjectUniquePropertyKeys;

+ (NSString *)remoteIDKey;

- (Class)managedObjectEntityClass;

- (NSManagedObjectID *)managedObjectID;

- (void)setManagedObjectID:(NSManagedObjectID *)managedObjectID;

- (void)objectFromNSManagedObject:(NSManagedObject *)managedObject;

- (BOOL)saveToLocal;

- (BOOL)saveToLocal:(NSError *__autoreleasing *)error;

- (void)saveToLocalInBackground;

- (void)saveToLocalInBackgroundWithBlock:(AVBooleanResultBlock)block;

- (void)saveToLocalInBackgroundWithTarget:(id)target selector:(SEL)selector;

- (BOOL)saveToServer;

- (BOOL)saveToServer:(NSError *__autoreleasing *)error;

- (void)saveToServerInBackground;

- (void)saveToServerInBackgroundWithBlock:(AVBooleanResultBlock)block;

- (void)saveToServerInBackgroundWithTarget:(id)target selector:(SEL)selector;

@end
