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
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath* editingIndexPath;  //当前左滑cell的index，在代理方法中设置

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[CelldelCell class] forCellReuseIdentifier:@"CelldelCell"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.editingIndexPath = nil;
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.editingIndexPath)
    {
        [self configSwipeButtons];
    }
}

- (void)configSwipeButtons
{
    // 获取选项按钮的reference
    UIButton *deleteButton;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
        //大于等于13
        for (UIView *subview in self.tableView.subviews) {
            UIView *pullView = subview.subviews.firstObject;
            if ([pullView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                //修改背景颜色
                pullView.backgroundColor =  [UIColor whiteColor];
                UIButton *swipeBtn = pullView.subviews[0];
                if ([swipeBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                    deleteButton = swipeBtn;
                }
            }
        }
    }else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))
    {
        // iOS 11层级 (Xcode 8编译): UITableView -> UITableViewWrapperView -> UISwipeActionPullView
        /**
        for (UIView *subview in self.tableView.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
            {
                for (UIView *subsubview in subview.subviews)
                {
                    if ([subsubview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subsubview.subviews count] >= 2)
                    {
                        // 和iOS 10的按钮顺序相反
                        deleteButton = subsubview.subviews[0];
//                        UIButton *readButton = subsubview.subviews[0];

                        [self configDeleteButton:deleteButton];
//                        [self configReadButton:readButton];
                    }
                }
            }
        }
         */
        // iOS 11层级 (Xcode 11编译): UITableView -> UISwipeActionPullView
        for (UIView *subview in self.tableView.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                //修改背景颜色
                subview.backgroundColor = [UIColor clearColor];
                UIButton *swipeBtn = subview.subviews[0];
                if ([swipeBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                    deleteButton = swipeBtn;
                }
            }
        }
    }else{
        // iOS 8-10层级: UITableView -> UITableViewCell -> UITableViewCellDeleteConfirmationView
        CelldelCell *tableCell = [self.tableView cellForRowAtIndexPath:self.editingIndexPath];
        for (UIView *subview in tableCell.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
            {
                deleteButton = subview.subviews[0];
                [subview setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
    [self configDeleteButton:deleteButton];
}

- (void)configDeleteButton:(UIButton*)deleteButton
{
    if (deleteButton)
    {
        [deleteButton setImage:[UIImage imageNamed:@"timedel"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor whiteColor]];
        // 调整按钮上图片和文字的相对位置（该方法的实现在下面）
//        [self centerImageAndTextOnButton:deleteButton];
    }
}

- (void)centerImageAndTextOnButton:(UIButton*)button
{
    // this is to center the image and text on button.
    // the space between the image and text
    CGFloat spacing = 35.0;
    
    // lower the text and push it left so it appears centered below the image
    CGSize imageSize = button.imageView.image.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered above the text
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = (titleSize.height - imageSize.height) / 2.0;
    button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
    
    // move whole button down, apple placed the button too high in iOS 10
    if (SYSTEM_VERSION_LESS_THAN(@"11.0"))
    {
        CGRect btnFrame = button.frame;
        btnFrame.origin.y = 18;
        button.frame = btnFrame;
    }
}
@end
