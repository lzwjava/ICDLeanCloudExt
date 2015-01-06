//
//  AVObject+ReactiveCocoa.m
//  ICDLeanCloudExt
//
//  Created by LEI on 1/6/15.
//  Copyright (c) 2015 TouchingApp. All rights reserved.
//

#import "AVObject+ReactiveCocoa.h"
#import <ReactiveCocoa.h>

@implementation AVObject (ReactiveCocoa)

- (RACSignal *)rac_saveToLocal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error;
        [self saveToLocal:&error];
        if (error){
            [subscriber sendNext:error];
        }else{
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

- (RACSignal *)rac_saveToServer{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error;
        [self saveToServer:&error];
        if (error){
            [subscriber sendNext:error];
        }else{
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

@end
