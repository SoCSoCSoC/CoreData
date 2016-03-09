//
//  CoreDataViewController.h
//  LessonCoreData
//
//  Created by CoderQiao on 15/3/7.
//  Copyright © 2015年 QQ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"  //这两个延展用于配合版本迁移

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *gender;
@property (nonatomic) int32_t age;
@property (nonatomic) float price;

@end

NS_ASSUME_NONNULL_END
