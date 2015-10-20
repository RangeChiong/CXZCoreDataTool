//
//  CXZCoreDateUtils.h
//  Test1009
//
//  Created by CXZ on 15/10/10.
//  Copyright © 2015年 Ranger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXZCoreDateUtils : NSObject

/**
 *  获取目标类的所有属性 只包含名称 不包括属性值
 *
 *  @param aClass 目标类
 *
 *  @return 存放目标累的属性名称的数组
 */
+ (NSArray *)fetchAllProperties:(Class)aClass;

@end
