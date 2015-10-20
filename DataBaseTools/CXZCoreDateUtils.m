//
//  CXZCoreDateUtils.m
//  Test1009
//
//  Created by CXZ on 15/10/10.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import "CXZCoreDateUtils.h"
#import <objc/runtime.h>

@implementation CXZCoreDateUtils

+ (NSArray *)fetchAllProperties:(Class)aClass {

    // 声明一个无符号整型
    u_int count;

    // 获取目标类中的属性列表  将数量赋给count
    objc_property_t *properties = class_copyPropertyList(aClass, &count);

    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        // 获取属性名称 转码后存到数组
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);

    return propertiesArray;
}

@end
