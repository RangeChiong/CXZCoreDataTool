//
//  CXZCoreDataTool.h
//  Test1009
//
//  Created by CXZ on 15/10/9.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CXZCoreDateUtils.h"

// 获取类名
#define CLASS_NAME(__cls__) NSStringFromClass([__cls__ class])

@interface CXZCoreDataTool : NSObject

@property (nonatomic, copy) NSString *datastoreFileName;    //!< 数据库文件名 默认情况下是工程名
@property (nonatomic, strong) NSURL *applicationDocumentsDirectory;    //!< sqlite文件的路径  默认是在Documents下
@property (nonatomic, copy) NSString *projectName;    //!< 获取项目名称 默认情况下是作为coreData编辑器的名字

+ (CXZCoreDataTool *)shareTool;


// 以下 core data

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (BOOL)saveContext;

@end

// 以下 category

#import "CXZCoreDataTool+Manager.h"