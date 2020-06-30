//
//  CelldelCell.m
//  CellDelDemo
//
//  Created by jhmac on 2020/6/30.
//  Copyright © 2020 iTBoyer. All rights reserved.
//

#import "CelldelCell.h"
#import "CellDelButtonItem.h"

@interface CelldelCell()
@property (strong, nonatomic) UIView *deleteView;
@end

@implementation CelldelCell
//
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_deleteView) {
            [self deleteView];
        }
    }
    return self;
}

-(UIView *)deleteView
{
    if (!_deleteView) {
        CGFloat screenw = [UIScreen mainScreen].bounds.size.width;
        _deleteView = [[UIView alloc]initWithFrame:CGRectMake(screenw, 0, screenw, 100)];
        _deleteView.backgroundColor = [UIColor whiteColor];
         [self addSubview:_deleteView];
        //ButtonItem是我自己定义的一个控件，"icon_delete"是删除按钮的图片
        CellDelButtonItem *deleteBtn = [[CellDelButtonItem alloc] initWithFrame:CGRectMake(0, 0, 80, 100)
                                                                  WithImageName:@"timedel"
                                                                 WithImageWidth:48
                                                   WithImageHeightPercentInItem:.7
                                                                      WithTitle:NSLocalizedString(@"DeleteOrder", nil)
                                                                   WithFontSize:14
                                                                  WithFontColor:[UIColor blackColor]
                                                                        WithGap:-5];

        [_deleteView addSubview:deleteBtn];
    }
    return _deleteView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (!_deleteView) {
        [self.contentView addSubview:self.deleteView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
