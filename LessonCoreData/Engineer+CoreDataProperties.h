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

#import "Engineer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Engineer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int32_t age;

@end

NS_ASSUME_NONNULL_END
