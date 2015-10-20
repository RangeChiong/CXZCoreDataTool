//
//  CXZCoreDataTool+Manager.h
//  Test1009
//
//  Created by CXZ on 15/10/9.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import "CXZCoreDataTool.h"

@interface CXZCoreDataTool (Manager)

// 创建实体描述对象  然后赋值 直接saveContext就可以了
- (__kindof NSManagedObject *)createModel:(NSString *)aClassName;

//----------------------------------插入数据----------------------------------

// 这两个方法配合使用  先newEntity 获得实体对象后再构造成数组 调用第二个方法
// 这里千万不能create 不然会有问题 原因待研究
- (__kindof NSManagedObject *)newEntityWithName:(NSString *)aClassName;
- (BOOL)insertCoreData:(NSArray *)dataArray;

// 先构造一个字典 键值对应上模型的属性和属性值 然后调用该方法
- (BOOL)insertCoreData:(NSString *)aClassName setWithDict:(NSDictionary *)dict;

// 这里block回调返回一个NSManagedObject类型的对象 然后用KVC在block里面赋值
// 或者强转成你定义的实体类来属性赋值
- (void)insertCoreData:(NSString *)aClassName setValue:(void(^)(NSManagedObject *obj))setValue;


//----------------------------------查询数据----------------------------------

- (NSArray *)searchCoreData:(NSString *)aClassName;
- (NSArray *)searchCoreData:(NSString *)aClassName predicate:(NSString *)predicateString;


//----------------------------------删除数据----------------------------------

- (BOOL)deleteCoreData:(NSString *)aClassName predicate:(NSString *)predicateString;

//----------------------------------更改数据----------------------------------

- (BOOL)updateCoreData:(NSString *)aClassName
             predicate:(NSString *)predicateString
                update:(void(^)(__kindof NSManagedObject *obj))update;

@end
