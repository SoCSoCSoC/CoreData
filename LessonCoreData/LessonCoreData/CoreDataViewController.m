//
//  CoreDataViewController.h
//  LessonCoreData
//
//  Created by CoderQiao on 15/3/7.
//  Copyright © 2015年 QQ. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"
#import "Engineer.h"
@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行数据初始化
    AppDelegate *dele = [UIApplication sharedApplication].delegate;
    self.myContext = dele.managedObjectContext;
    
    self.allData = [NSMutableArray array];
    
    
    //通过CoreData读取本地所有的数据
    [self getAllDataFromCoreData];//自定义的方法
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)getAllDataFromCoreData{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Engineer" inManagedObjectContext:self.myContext];
    [fetchRequest setEntity:entity];
    
    // Specify criteria for filtering which objects to fetch
//    //谓词，过滤
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    
    
    // Specify how the fetched objects should be sorted
    //排序条件     //sort 排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"神马都没fetch到");
    }
    //将查询到的数据添加到数据源
    [self.allData addObjectsFromArray:fetchedObjects];
    //重新加载tableView
    [self.tableView reloadData];
}

//添加数据
- (IBAction)addAction:(UIBarButtonItem *)sender {
    //1. 创建Engineer对象
    //创建一个实体描述对象
    NSEntityDescription *engineerDiscription = [NSEntityDescription entityForName:@"Engineer" inManagedObjectContext:self.myContext];
    Engineer *engineer = [[Engineer alloc] initWithEntity:engineerDiscription insertIntoManagedObjectContext:self.myContext];
    //给属性赋值
    engineer.name = @"Sven";
    engineer.age = arc4random() % 73 + 1;
    //1. 修改数据源
    [self.allData addObject:engineer];
    //2. 修改界面
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.allData.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft]; //***************nnnnn
    //将数据保存到文件中进行持久化
//    NSError *error = nil;
//    [self.myContext save:&error];
//    if (nil != error) {
//        NSLog(@"持久化存在问题");
//    }
    [((AppDelegate *)[UIApplication sharedApplication].delegate) saveContext];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    Engineer *engineer = self.allData[indexPath.row];
    cell.textLabel.text = engineer.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", engineer.age];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
//当点击tableViewCell的删除按钮的时候会调用（当提交编辑请求的时候会调用）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //1 获取当前cell代表的数据
        Engineer *engineer = self.allData[indexPath.row];
        //2 更新数据源
        [self.allData removeObject:engineer];
        //3 更新UI
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //将临时数据库里进行删除并进行本地持久化
        [self.myContext deleteObject:engineer];
        [self.myContext save:nil];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//点击cell的响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1 更第一步
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Engineer" inManagedObjectContext:self.myContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myContext executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        <#Error handling code#>
//    }
    
    //修改对应的数据
    Engineer *engineer = self.allData[indexPath.row];
    engineer.name = @"Lorraine";
    //更新数据源
    [self.allData removeAllObjects];  //这里删了所有的然后重新加（为了省事）， 单独更新一个也可以
    [self.allData addObjectsFromArray:fetchedObjects];
    //更新界面
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //修改本地持久化
    [self.myContext save:nil];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
//<(￣▽￣)>    ╰(￣▽￣)╮
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
