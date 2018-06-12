//
//  ExampleTableViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ExampleTableViewController.h"

@interface ExampleTableViewController ()

@end

@implementation ExampleTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
  
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是%@--------%zi",self.title,indexPath.row];
 
    return cell;
}



@end
