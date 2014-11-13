//
//  LeftViewController.m
//  WYApp
//
//  Created by chen on 14-7-17.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "LeftViewController.h"
#import "Macro.h"
#import "SliderViewController.h"
#import "NextViewController.h"
#import "WebContainerController.h"
#import "IndexViewController.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableDictionary *dic;//存对应的数据
    NSMutableArray *selectedArr;//二级列表是否展开状态
    NSMutableArray *nameDataArray;
    NSMutableArray *titleUrlArray;
    NSMutableArray *imageArray;
    NSMutableArray *nameUrlArray;
    NSArray *resultArray;//数据源，显示每个cell的数据
    NSMutableArray *childrenArray;
    NSMutableArray *grouparr;
    NSMutableDictionary *totalDic;
    
    NSString *lastString;

}
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addObserver];
    lastString=@"";

    
    [self.view setBackgroundColor:RGBACOLOR(51, 51, 51, 1)];

    selectedArr = [[NSMutableArray alloc] init];
    resultArray = [[NSArray alloc] init];
    nameDataArray = [[NSMutableArray alloc] init];
    childrenArray = [[NSMutableArray alloc] init];
    imageArray = [NSMutableArray new];
    nameUrlArray = [[NSMutableArray alloc] init];
    grouparr = [[NSMutableArray alloc] init];
    
    //tableView
      _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //不要分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self loadData];
}

-(void)loadData{
    NSString *urlStr = @"http://www.spyg.com.cn/app/nav_list.php";
    NSString* urlEncoding = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest* urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    //通过NSURLConnection 发送NSURLRequest，这里是同步的，因此会又等待的过程，TIME_OUT为超时时间。
    //error可以获取失败的原因。
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:urlrequest returningResponse:NULL error:&error];
    if(!error){
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        resultArray = [dataDict objectForKey:@"result"];
        for (NSDictionary *resultDict in resultArray ) {
            [imageArray addObject:[resultDict objectForKey:@"img_url"]];
            [nameUrlArray addObject:[resultDict objectForKey:@"url"]];
            [nameDataArray addObject:[resultDict objectForKey:@"name"]];
            [childrenArray addObject:[resultDict objectForKey:@"children"]];
            
        }
        
        dic=[[NSMutableDictionary alloc] initWithCapacity:0];
        totalDic=[[NSMutableDictionary alloc] initWithCapacity:0];
        int i=0;
        for (NSArray *nameArr in childrenArray)
        {
            titleUrlArray = [[NSMutableArray alloc] init];
            grouparr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic2 in nameArr)
            {
                [grouparr addObject:[dic2 objectForKey:@"name"]];
                [titleUrlArray addObject:[dic2 objectForKey:@"url"]];
            }
            [totalDic setValue:grouparr  forKey:[NSString stringWithFormat:@"%d",i]];
            [dic setValue:titleUrlArray  forKey:[NSString stringWithFormat:@"%d",i]];
            i++;
        }
    }
    NSString* errorString = [error localizedDescription];
    if (errorString != nil) {
        NSLog(@"errorString = %@",errorString);
    }
}

- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBar];
}

- (void)toNewViewbtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
    {
    }];
}

#pragma mark----tableViewDelegate
//返回几个表头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return nameDataArray.count;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    
    if ([selectedArr containsObject:string]) {
        
        NSArray *array1 = totalDic[string];
        return array1.count;
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    NSString *imageUrl = [imageArray objectAtIndex:section];
    
    UIImage* image=nil;
    NSURL* url = [NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//网络图片url
    NSData* data = [NSData dataWithContentsOfURL:url];//获取网咯图片数据
    if(data!=nil)
    {
        image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
    }
    CGSize size = CGSizeMake(20, 20);
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
//
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 223, 39.5);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 100);
    [btn.imageView setFrame:CGRectMake(20, 10, 20, 20)];
    [btn setTitleColor:RGBACOLOR(183, 183, 183, 1) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    [btn setTitle:[nameDataArray objectAtIndex:section] forState:UIControlStateNormal];
    [btn setImage:scaledImage forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section;
    [view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(222, 0, 39.5, 39.5);
    [btn1 setImage:[UIImage imageNamed:@"push_btn_bg"] forState:UIControlStateNormal];
    // 设置按钮内容的对齐方式
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    // 设置btn中的imageview不拉伸
    btn1.imageView.contentMode = UIViewContentModeCenter;
    
    // 设置btn中的imageview超出部分不剪切
    btn.imageView.clipsToBounds = NO;
    btn1.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    btn1.tag = 100+section;
//     btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(35, 39.5, 300, 0.5)];
    self.imageV.backgroundColor = [UIColor blackColor];
//    self.imageV.image = [UIImage imageNamed:@"left_line"];
    [view addSubview:self.imageV];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当前是第几个表头
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        if ([selectedArr containsObject:indexStr]) {
            
           UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 44)];
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.text = totalDic[indexStr][indexPath.row];
            nameLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLabel];
        }
        
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    WebContainerController *themeVC = [[WebContainerController alloc] initWithUrl:dic[indexStr][indexPath.row] title:totalDic[indexStr][indexPath.row]];
    [self.navigationController pushViewController:themeVC animated:YES];
}

-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",sender.tag-100];
    //数组selected  Arr里面存的数据和表头想对应，方便以后做比较
    
        if(![lastString isEqual:string]){
            [selectedArr removeObject:lastString];
            if ([selectedArr containsObject:string])
            {
                [selectedArr removeObject:string];
            }
            else
            {
                [selectedArr addObject:string];
            }
        }
        else {
            if ([selectedArr containsObject:lastString])
            {
                [selectedArr removeObject:lastString];
            }
            else
            {
                [selectedArr addObject:lastString];
            }

        }

   
    
    lastString=string;
    
        [_tableView reloadData];
}

-(void)pushBtnClick:(UIButton *)sender{
    NextViewController *nvc = [[NextViewController alloc] initWithUrl:[nameUrlArray objectAtIndex:sender.tag] title:[nameDataArray objectAtIndex:sender.tag]];
    [self.navigationController pushViewController:nvc animated:YES];
}

//#pragma mark - super
//
//- (void)reloadImage
//{
//    [super reloadImage];
//  
//    [_tableView reloadData];
//}
//
//- (void)reloadImage:(NSNotificationCenter *)notif
//{
//    [self reloadImage];
//}

@end
