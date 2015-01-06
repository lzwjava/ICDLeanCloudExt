//
//  AVObject+ReactiveCocoa.h
//  ICDLeanCloudExt
//
//  Created by LEI on 1/6/15.
//  Copyright (c) 2015 TouchingApp. All rights reserved.
//

#import "AVObject+CoreData.h"
#import <AVObject.h>

@class RACSignal;

@interface AVObject (ReactiveCocoa)

- (RACSignal *)rac_saveToLocal;

- (RACSignal *)rac_saveToServer;

@end
