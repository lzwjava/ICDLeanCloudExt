//
//  ICDLeanCloudExtTests.m
//  ICDLeanCloudExtTests
//
//  Created by LEI on 1/3/15.
//  Copyright (c) 2015 TouchingApp. All rights reserved.
//

#import <Specta.h> // #import "Specta.h" if you're using cocoapods or libSpecta.a
#define EXP_SHORTHAND
#import <Expecta.h>
#import "ICDLeanCloudExt.h"
#import "DataTypeEntity.h"
#import "OneToOneEntity.h"
#import "OneToManyEntity.h"
#import <ISO8601DateFormatter.h>

SpecBegin(Object)

describe(@"AVObject+CoreData", ^{
    
    ISO8601DateFormatter *dateFormatter = [ISO8601DateFormatter new];
    __block AVObject *testObject;
    
    beforeAll(^{
        setenv("LOG_CURL", "YES", 0);
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        [AVOSCloud setApplicationId:@"gi3timxkd2cy55wdy4gn1zyxf2fzq5fcn9cr2hmgu77dva59"
                          clientKey:@"ywxaz8dbhmtshemuaymp6voj58pqc60le9919uixoqyg424u"];
        
    });
    beforeEach(^{
        testObject = [AVObject objectWithClassName:@"DataTypeEntity"];
        NSDate *now = [NSDate date];
        [testObject setObject:@1.223 forKey:@"number"];
        [testObject setObject:@YES forKey:@"boolean"];
        NSMutableData *data = [NSMutableData new];
        [data appendBytes:"\x01\x02\x03" length:3];
        [testObject setObject:data forKey:@"data"];
        [testObject setObject:@[@"12", @123, @YES, @"jj"] forKey:@"array"];
        [testObject setObject:@{@"a1":@"b2", @"a2":@(1), @"a3":@"sd"} forKey:@"dict"];
        [testObject setObject:now forKey:@"date"];
        [testObject setObject:nil forKey:@"nullv"];
    });
    
    it(@"AVObject save to CoreData", ^{
        [testObject setObject:@"s1" forKey:@"string"];
        NSError *error;
        [testObject saveToLocal:&error];
        if (error){
            NSLog(@"error: %@", [error localizedDescription]);
        }else{
            NSLog(@"success");
        }
        DataTypeEntity *object = [DataTypeEntity MR_findFirstByAttribute:@"string" withValue:@"s1"];
        expect(object.string).to.equal([testObject objectForKey:@"string"]);
        expect(object.number).to.equal([testObject objectForKey:@"number"]);
        expect(object.boolean).to.equal([testObject objectForKey:@"boolean"]);
        expect([dateFormatter stringFromDate:object.date]).to.equal([dateFormatter stringFromDate:[testObject objectForKey:@"date"]]);
        expect(object.nullv).to.equal([testObject objectForKey:@"nullv"]);
        expect(object.data).to.equal([testObject objectForKey:@"data"]);
        
    });
    
    it(@"CoreData to AVObject", ^{
        DataTypeEntity *object = [DataTypeEntity MR_findFirstByAttribute:@"string" withValue:@"s1"];
        AVObject *o = [AVObject objectWithClassName:@"DataTypeEntity"];
        [o objectFromNSManagedObject:object];
        expect(object.string).to.equal([o objectForKey:@"string"]);
        expect(object.number).to.equal([o objectForKey:@"number"]);
        expect(object.boolean).to.equal([o objectForKey:@"boolean"]);
        expect([dateFormatter stringFromDate:object.date]).to.equal([dateFormatter stringFromDate:[testObject objectForKey:@"date"]]);
        expect(object.nullv).to.equal([o objectForKey:@"nullv"]);
        expect(object.data).to.equal([o objectForKey:@"data"]);
    });
    
    it(@"AVObject save to CoreData Relationships", ^{
        [testObject setObject:@"s2" forKey:@"string"];
        AVObject *oneObject = [AVObject objectWithClassName:@"OneToOneEntity"];
        [oneObject setObject:@"name1" forKey:@"name"];
        [testObject setObject:oneObject forKey:@"onetoone"];
        
        AVObject *twoObject1 = [AVObject objectWithClassName:@"OneToManyEntity"];
        [twoObject1 setObject:@"name1" forKey:@"name"];
        [twoObject1 saveToLocal];
        [twoObject1 saveToServer];
        AVObject *twoObject2 = [AVObject objectWithClassName:@"OneToManyEntity"];
        [twoObject2 setObject:@"name2" forKey:@"name"];
        [twoObject2 saveToLocal];
        [twoObject2 saveToServer];
        AVObject *twoObject3 = [AVObject objectWithClassName:@"OneToManyEntity"];
        [twoObject3 setObject:@"name3" forKey:@"name"];
        [twoObject3 saveToLocal];
        [twoObject3 saveToServer];
        OneToManyEntity *managedObject = [OneToManyEntity MR_findFirstByAttribute:@"objectID" withValue:twoObject3.managedObjectID];
        expect(managedObject.name).to.equal([twoObject3 objectForKey:@"name"]);
        [twoObject3 setObject:@"name4" forKey:@"name"];
        [twoObject3 saveToLocal];
        [twoObject3 saveToServer];
        managedObject = [OneToManyEntity MR_findFirstByAttribute:@"objectID" withValue:twoObject3.managedObjectID];
        expect(managedObject.name).to.equal([twoObject3 objectForKey:@"name"]);
        
        AVRelation *relation = [testObject relationforKey:@"onetomany"];
        [relation addObject:twoObject1];
        [relation addObject:twoObject2];
        [relation addObject:twoObject3];
        [testObject save];
        
        NSError *error;
        [testObject saveToLocal:&error];
        [twoObject3 saveToServer];
        if (error){
            NSLog(@"error: %@", [error localizedDescription]);
        }else{
            NSLog(@"success");
        }
        DataTypeEntity *object = [DataTypeEntity MR_findFirstByAttribute:@"string" withValue:@"s2"];
        expect(object.string).to.equal([testObject objectForKey:@"string"]);
        expect(object.number).to.equal([testObject objectForKey:@"number"]);
        expect(object.boolean).to.equal([testObject objectForKey:@"boolean"]);
        expect([dateFormatter stringFromDate:object.date]).to.equal([dateFormatter stringFromDate:[testObject objectForKey:@"date"]]);
        expect(object.nullv).to.equal([testObject objectForKey:@"nullv"]);
        expect(object.data).to.equal([testObject objectForKey:@"data"]);
        expect(object.onetoone.name).to.equal([oneObject objectForKey:@"name"]);
    });
    
    it(@"CoreData to AVObject with Relationship", ^{
        AVQuery *dateTypeObjectQuery = [AVQuery queryWithClassName:@"DataTypeEntity"];
        AVObject *object = [dateTypeObjectQuery getFirstObject];
        [object saveToLocal];
        DataTypeEntity *dataTypeEntity = [DataTypeEntity MR_findFirst];
        expect(dataTypeEntity.objectId).notTo.beNil();
        dataTypeEntity.string = @"2222";
        AVObject *object1 = [AVObject objectWithClassName:@"DataTypeEntity"];
        [object1 objectFromNSManagedObject:dataTypeEntity];
        [object1 saveToServer];
        [object refresh];
        expect([object objectForKey:@"string"]).to.equal(dataTypeEntity.string);
    });


});

SpecEnd