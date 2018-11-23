//
//  MainTabBarController.m
//  PoemKing
//
//  Created by Leon Guo on 2018/10/11.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import "MainTabBarController.h"



@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *oldPath = [[NSBundle mainBundle] pathForResource:@"WCDB_Contact" ofType:@".sqlite"];
    NSString *newPath = [docuPath stringByAppendingPathComponent:@"WCDB_Contact.sqlite"];
    
    if(![fileManager fileExistsAtPath:newPath]){
        NSLog(@"File doesn't exists");
        BOOL isSuccess = [fileManager copyItemAtPath:oldPath toPath:newPath error:nil];
        NSLog(@"Copy file %@",isSuccess?@"Success":@"Faliure");
    }else{
        NSLog(@"File has already exists %@",newPath);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
