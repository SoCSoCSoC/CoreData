//
//  CoreDataViewController.h
//  LessonCoreData
//
//  Created by CoderQiao on 15/3/7.
//  Copyright © 2015年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//被管理对象上下文，相当于一个临时数据库，我们存储或者查询都是通过这个对象来的
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理对象模型，可以简单地理解为可视化建模文件，我们在可视化建模中是Entity，自动生成Model，就是这个对象。方便让文件存储助理来进行管理
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//文件存储助理，他是CoreData的核心，他负责链接所有的模块，包括真实的存储文件
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; //persistent固执的，坚持的；持久稳固的 Coordinator协调者

//将我们在内存中的操作进行持久化
- (void)saveContext;
//获取真实文件的路径
- (NSURL *)applicationDocumentsDirectory;



@end

