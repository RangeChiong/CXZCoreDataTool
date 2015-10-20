//
//  CXZCoreDataTool+Manager.m
//  Test1009
//
//  Created by CXZ on 15/10/9.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import "CXZCoreDataTool+Manager.h"

@implementation CXZCoreDataTool (Manager)

#pragma mark-   创建实体对象

- (__kindof NSManagedObject *)createModel:(NSString *)aClassName {
    
    return [NSEntityDescription insertNewObjectForEntityForName:aClassName inManagedObjectContext:[self managedObjectContext]];
}

#pragma mark-   创建拉取请求

- (NSFetchRequest *)createFetchRequest:(NSString *)className predicate:(NSString *)predicateString {

    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:className inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];

    if (predicateString != nil) {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:predicateString];
        [fetchRequest setPredicate:predicate];
    }
    return fetchRequest;
}

#pragma mark-   插入数据

- (__kindof NSManagedObject *)newEntityWithName:(NSString *)aClassName {
    return [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:aClassName
                                                               inManagedObjectContext:[self managedObjectContext]]
                    insertIntoManagedObjectContext:nil];
}

- (BOOL)insertCoreData:(NSArray *)dataArray
{
    BOOL isSave = NO;
    for (NSManagedObject *entity in dataArray) {
        NSManagedObject *obj = [self createModel:CLASS_NAME(entity)];
        for (NSString * propertyName in [CXZCoreDateUtils fetchAllProperties:[entity class]]) {
            // 获取new的实体对象在外面的属性赋值 然后通过KVC赋值给create的对象
            [obj setValue:[entity valueForKey:propertyName] forKey:propertyName];
        }
        isSave = [self saveContext];
    }
    return isSave;
}

- (BOOL)insertCoreData:(NSString *)aClassName setWithDict:(NSDictionary *)dict {
    
    // 创建实体描述对象
    NSManagedObject * obj = [self createModel:aClassName];
    
    if (obj != nil) {
        
        // 赋值
        [obj setValuesForKeysWithDictionary:dict];
        
        // 保存数据
        return [self saveContext];
    }
    return NO;
}

- (void)insertCoreData:(NSString *)aClassName setValue:(void(^)(NSManagedObject *obj))setValue {
    // 创建实体描述对象
    NSManagedObject * obj = [self createModel:aClassName];
    // 赋值
    if (obj != nil) {
        
        if (setValue) {
            // 把实体返回出去赋值 在外面用KVC赋值 或者强转成你定义的实体类来属性赋值
            setValue(obj);
        }
        // 保存数据
        [self saveContext];
    }
}

#pragma mark-   查询数据

- (NSArray *)searchCoreData:(NSString *)aClassName {
    return [self searchCoreData:aClassName predicate:nil];
}

- (NSArray *)searchCoreData:(NSString *)aClassName predicate:(NSString *)predicateString
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [self createFetchRequest:aClassName predicate:predicateString];

    NSError *error;
    return [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


#pragma mark-   删除数据
- (BOOL)deleteCoreData:(NSString *)aClassName predicate:(NSString *)predicateString
{
    NSArray *entityArr = [self searchCoreData:aClassName predicate:predicateString];
    if (!entityArr.count) {
        NSLog(@"未找到数据");
        return NO;
    }
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    BOOL hasDeleted = YES;
    for (NSManagedObject *obj in entityArr)
    {
        [managedObjectContext deleteObject:obj];

        if ([obj isDeleted]) {
            hasDeleted = [self saveContext];
        }else {
            NSLog(@"failed to delete the core data");
            hasDeleted = NO;
        }
    }
    return hasDeleted;
}

#pragma mark-   更改数据
- (BOOL)updateCoreData:(NSString *)aClassName
             predicate:(NSString *)predicateString
                update:(void(^)(__kindof NSManagedObject *obj))update {
    NSArray *entityArr = [self searchCoreData:aClassName predicate:predicateString];
    if (!entityArr.count) {
        NSLog(@"未找到数据");
        return NO;
    }
    for (NSManagedObject *entity in entityArr) {
        !update ?: update(entity);
    }

    return [self saveContext];
}

@end
