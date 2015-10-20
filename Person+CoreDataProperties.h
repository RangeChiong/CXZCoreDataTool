//
//  Person+CoreDataProperties.h
//  CXZCoreDataTool
//
//  Created by CXZ on 15/10/20.
//  Copyright © 2015年 Ranger. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *age;
@property (nullable, nonatomic, retain) NSString *sex;

@end

NS_ASSUME_NONNULL_END
