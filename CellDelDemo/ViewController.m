//
//  ViewController.m
//  CellDelDemo
//
//  Created by jhmac on 2020/6/30.
//  Copyright © 2020 iTBoyer. All rights reserved.
//

#import "ViewController.h"
#import "CelldelCell.h"
//#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[CelldelCell class] forCellReuseIdentifier:@"CelldelCell"];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CelldelCell";
    
//    CelldelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
//    if(cell == nil) {
    CelldelCell * cell = [[CelldelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
//    return @"通过改变title的长度，你想多宽就多宽";

}
@end
