//
//  AVObject+CoreData.m
//  ICDLeanCloudExt
//
//  Created by LEI on 1/3/15.
//  Copyright (c) 2015 TouchingApp. All rights reserved.
//

#import "AVObject+CoreData.h"
#import <objc/runtime.h>

@interface ICDCoreDataAdapter : NSObject

+ (id)managedObjectFromAVObject:(AVObject *)object insertingIntoContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end

@implementation ICDCoreDataAdapter

+ (id)managedObjectFromAVObject:(AVObject *)object insertingIntoContext:(NSManagedObjectContext *)context error:(NSError **)error{
    if (object == nil) return nil;
    Class entityClass = [object managedObjectEntityClass];
    NSManagedObject *managedObject = nil;
    if (object.objectId){
        managedObject = [entityClass MR_findFirstByAttribute:[object.class remoteIDKey] withValue:object.objectId inContext:context];
    }
    if (!managedObject){
        NSManagedObjectID *managedObjectID = [object managedObjectID];
        if (managedObjectID){
            managedObject = [entityClass MR_findFirstByAttribute:@"objectID" withValue:managedObjectID inContext:context];
        }else{
            NSPredicate *uniquingPredicate = [self uniquingPredicateForObejct:object];
            if (uniquingPredicate != nil){
                managedObject = [entityClass MR_findFirstWithPredicate:uniquingPredicate inContext:context];
            }
        }
    }
    if (managedObject == nil){
        managedObject = [entityClass MR_createInContext:context];
        [self updateValuesForManagedObject:managedObject fromAVObject:object context:context error:error];
        [managedObject validateForInsert:error];
    }else{
        // update value
        [self updateValuesForManagedObject:managedObject fromAVObject:object context:context error:error];
        [managedObject validateForUpdate:error];
    }
    if (*error){
        [managedObject MR_deleteInContext:context];
        return nil;
    }
    return managedObject;
}

+ (void)updateValuesForManagedObject:(NSManagedObject *)managedObject fromAVObject:(AVObject *)object context:(NSManagedObjectContext *)context error:(NSError **)error{
    NSArray *keys = [object allKeys];
    [keys enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        NSString *managedObjectKey = [self managedObjectKeyForPropertyKey:key fromObject:object];
        if (managedObjectKey == nil) return;
        id value = [object objectForKey:key];
        if ([value isKindOfClass:[AVObject class]]){
            [managedObject setValue:[ICDCoreDataAdapter managedObjectFromAVObject:value insertingIntoContext:context error:error] forKey:managedObjectKey];
        }else if ([value isKindOfClass:[AVRelation class]]){
            
        }else{
            [managedObject setValue:value forKey:managedObjectKey];
        }
    }];
    [managedObject setValue:object.objectId forKey:[object.class remoteIDKey]];
}

+ (NSPredicate *)uniquingPredicateForObejct:(AVObject *)object {
    if (![object.class respondsToSelector:@selector(managedObjectUniquePropertyKeys)]){
        return nil;
    }
    NSSet *propertyKeys = [object.class managedObjectUniquePropertyKeys];
    if (propertyKeys.count == 0){
        return nil;
    }
    NSMutableArray *subpredicates = [NSMutableArray array];
    for (NSString *propertyKey in propertyKeys) {
        NSString *managedObjectKey = [self managedObjectKeyForPropertyKey:propertyKey fromObject:object];
        if (managedObjectKey == nil){
            continue;
        }
        id value = [object objectForKey:propertyKey];
        NSPredicate *subpredicate = [NSPredicate predicateWithFormat:@"%K == %@", managedObjectKey, value];
        [subpredicates addObject:subpredicate];
    }
    
    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

+ (NSString *)managedObjectKeyForPropertyKey:(NSString *)propertyKey fromObject:(AVObject *)object{
    if (propertyKey == nil){
        return nil;
    }
    Class entityClass = [object managedObjectEntityClass];
    id managedObjectKey = [object.class managedObjectKeysByPropertyKey][propertyKey];
    // remove key if NSNull
    if ([managedObjectKey isEqual:NSNull.null]) return nil;
    if (managedObjectKey == nil) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(entityClass) inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
        NSArray *attributeKeys = [[entityDescription attributesByName] allKeys];
        NSArray *relationshipKeys = [[entityDescription relationshipsByName] allKeys];
        NSArray *keys = [attributeKeys arrayByAddingObjectsFromArray:relationshipKeys];
        if ([keys containsObject:propertyKey]){
            return propertyKey;
        }else{
            return nil;
        }
    }else{
        return managedObjectKey;
    }
}

@end

static char AVObjectNSManagedObejct;

@implementation AVObject (CoreData)

- (Class)managedObjectEntityClass{
    return NSClassFromString(self.className);
}

+ (NSDictionary *)managedObjectKeysByPropertyKey{
    return nil;
}

+ (NSDictionary *)managedRelationshipClassesByPropertyKey{
    return nil;
}

// 此处key为avobject的key
+ (NSSet *)managedObjectUniquePropertyKeys{
    return nil;
}

+ (NSString *)remoteIDKey{
    return [self managedObjectKeysByPropertyKey][@"objectId"]?:@"objectId";
}

- (NSManagedObjectID *)managedObjectID{
    return objc_getAssociatedObject(self, &AVObjectNSManagedObejct);
}

- (void)setManagedObjectID:(NSManagedObjectID *)managedObjectID{
    objc_setAssociatedObject(self, &AVObjectNSManagedObejct, managedObjectID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)objectFromNSManagedObject:(NSManagedObject *)managedObject{
    NSArray *keys = [[[managedObject entity] attributesByName] allKeys];
    NSDictionary *dict = [managedObject dictionaryWithValuesForKeys:keys];
    for (NSString *key in dict) {
        if ([key isEqualToString:self.class.remoteIDKey]){
            if (dict[self.class.remoteIDKey] != NSNull.null){
                self.objectId = dict[self.class.remoteIDKey];
            }
        }else{
            if (dict[key] == NSNull.null){
                [self setObject:nil forKey:key];
            }else if (![[self objectForKey:key] isEqual:dict[key]]){
                [self setObject:dict[key] forKey:key];
            }
        }
    }
    
}

- (BOOL)saveToLocal{
    NSError *error;
    return [self saveToLocal:&error];
}

- (BOOL)saveToLocal:(NSError *__autoreleasing *)error{
    __block NSManagedObject *managedObject;
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        managedObject = [ICDCoreDataAdapter managedObjectFromAVObject:self insertingIntoContext:localContext error:error];
    }];
    if (!*error){
        [self setManagedObjectID:managedObject.objectID];
    }
    return *error == nil;
}

- (void)saveToLocalInBackground{
    __block NSManagedObject *managedObject;
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        managedObject = [ICDCoreDataAdapter managedObjectFromAVObject:self insertingIntoContext:localContext error:nil];
    }];
}

- (void)saveToLocalInBackgroundWithBlock:(AVBooleanResultBlock)block{
    __block NSManagedObject *managedObject;
    __block NSError *convertError;
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        managedObject = [ICDCoreDataAdapter managedObjectFromAVObject:self insertingIntoContext:localContext error:&convertError];
    } completion:^(BOOL success, NSError *error) {
        if (convertError){
            if (block) block(NO, convertError);
        }else{
            if (block) block(success, error);
        }
    }];
}

- (void)saveToLocalInBackgroundWithTarget:(id)target selector:(SEL)selector{
    __block NSManagedObject *managedObject;
    __block NSError *convertError;
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        managedObject = [ICDCoreDataAdapter managedObjectFromAVObject:self insertingIntoContext:localContext error:&convertError];
    } completion:^(BOOL success, NSError *error) {
        if (convertError){
            if ([target respondsToSelector:selector]){
                [target performSelector:selector withObject:@(NO) withObject:convertError];
            }
        }else{
            if ([target respondsToSelector:selector]){
                [target performSelector:selector withObject:@(success) withObject:error];
            }
        }
    }];
}

- (BOOL)saveToServer{
    NSError *error;
    return [self saveToServer:&error];
}

- (BOOL)saveToServer:(NSError *__autoreleasing *)error{
    [self save:error];
    if(!*error){
        [self updateManagedObjectID];
    }
    return *error == nil;
}

- (void)saveToServerInBackground{
    [self saveToServerInBackgroundWithBlock:nil];
}

- (void)saveToServerInBackgroundWithBlock:(AVBooleanResultBlock)block{
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            [self updateManagedObjectID];
        }
        if (block) block(succeeded, error);
    }];
}

- (void)saveToServerInBackgroundWithTarget:(id)target selector:(SEL)selector{
    [self saveInBackgroundWithTarget:target selector:selector];
}

- (void)updateManagedObjectID{
    id managedObject = [self.managedObjectEntityClass MR_findFirstByAttribute:@"objectID" withValue:self.managedObjectID];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        id localManagedObject = [managedObject MR_inContext:localContext];
        [localManagedObject setValue:self.objectId forKey:self.class.remoteIDKey];
    }];
}

@end
