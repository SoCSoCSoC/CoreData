//
//  CoreDataViewController.h
//  LessonCoreData
//
//  Created by CoderQiao on 15/3/7.
//  Copyright © 2015年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataViewController : UITableViewController

//创建一个上下文对象，用于处理所有与存储相关的请求
@property (nonatomic, strong) NSManagedObjectContext *myContext;
//创建一个数组，用于存储数组
@property (nonatomic, strong) NSMutableArray *allData;
@end
