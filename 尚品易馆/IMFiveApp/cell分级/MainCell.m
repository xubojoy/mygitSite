//
//  MainCell.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        //名字
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 44)];
        _nameLabel.backgroundColor  = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
//        //分割线
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(60, 59, 320-60, 0.5)];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)setMainCell
{
    
}

@end

