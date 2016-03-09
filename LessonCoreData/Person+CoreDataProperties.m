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

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

@dynamic name;
@dynamic gender;
@dynamic age;
@dynamic price;

@end
