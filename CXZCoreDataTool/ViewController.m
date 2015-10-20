//
//  ViewController.m
//  CXZCoreDataTool
//
//  Created by CXZ on 15/10/20.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import "ViewController.h"
#import "CXZCoreDataTool.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) CXZCoreDataTool *dbTool;  //!< coreData工具  是个单例

@end

@implementation ViewController

- (IBAction)add:(id)sender {
    Person *p = [self.dbTool newEntityWithName:CLASS_NAME(Person)];
    p.name = @"旺财";
    p.age = @"2";
    p.sex = @"1";

    Person *p1 = [self.dbTool newEntityWithName:CLASS_NAME(Person)];
    p1.name = @"小强";
    p1.age = @"2";
    p1.sex = @"1";

    ![self.dbTool insertCoreData:@[p,p1]] ?: NSLog(@"插入新数据成功");
}

- (IBAction)del:(id)sender {
    ![self.dbTool deleteCoreData:CLASS_NAME(Person) predicate:@"name = '旺财'"] ?:  NSLog(@"删除数据成功");
}

- (IBAction)update:(id)sender {
    ![self.dbTool updateCoreData:CLASS_NAME(Person) predicate:@"name = '小强'" update:^(__kindof NSManagedObject *obj) {
        [obj setValue:@"0" forKey:@"sex"];
    }] ?:  NSLog(@"数据更新成功");
}

- (IBAction)search:(id)sender {
    NSArray *resultArr = [self.dbTool searchCoreData:CLASS_NAME(Person) predicate:@"name = '小强'"];

    NSLog(@"查找数据为%@",resultArr);
}

- (CXZCoreDataTool *)dbTool {
    if (!_dbTool) {
        _dbTool = [CXZCoreDataTool shareTool];
    }
    return _dbTool;
}


@end
