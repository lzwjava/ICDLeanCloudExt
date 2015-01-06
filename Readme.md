ICDLeanCloudExt ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
=============

Leancloud 扩展, 支持Core Data本地存储和同步, 支持ReactiveCocoa

## Guide

主要通过 Category 的方式扩展了 AVObject 的功能(具体参见```AVObject+CoreData.{h,m}```):

```- (Class)managedObjectEntityClass```将```AVObject```与Core Data ```NSManagedObject```对应, 默认为当前```AVObject```的```ClassName```

```+ (NSString *)remoteIDKey```为Core Data ```NSManagedObject```中对应的 AVObject ```ObjectId```, 默认为 "ObjectId", 即 Core Data 模型中必须声明```String```类型的名叫```ObjectId```属性


## LICENSE

MIT Lincese (See ```LICENSE``` file for details).