//
//  ViewController.m
//  CellDelDemo
//
//  Created by jhmac on 2020/6/30.
//  Copyright © 2020 iTBoyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
    }
    return _tableView;
}

@end
