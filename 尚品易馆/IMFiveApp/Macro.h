//
//  Macro.h
//  点餐Demo
//
//  Created by 王园园 on 14-8-8.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

#ifndef __Demo_Macro_h
#define __Demo_Macro_h

//判断程序的版本
#define IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
#define IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define IOS_7_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define general_margin  10
#define status_bar_height   20
//#define IOS6_7_DELTA(V,X,Y,W,H) if(IOS_7) {CGRect f = V.frame;f.origin.x += X;f.origin.y += Y;f.size.width +=W;f.size.height += H;V.frame=f;}

//整个屏幕的宽和高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define VIEW_WEIGHT [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT (IOS_7 ?[UIScreen mainScreen].bounds.size.height :([UIScreen mainScreen].bounds.size.height-64))
#define VIEW_HEIGHT_TAB ([UIScreen mainScreen].bounds.size.height-113)

//控件的尺寸
#define WIDTH_VIEW(view) CGRectGetWidth(view.frame)
#define HEIGHT_VIEW(view) CGRectGetHeight(view.frame)
#define VIEW_MAXX(view) CGRectGetMaxX(view.frame)
#define VIEW_MAXY(view) CGRectGetMaxY(view.frame)

#define VIEW_oringeY  (IOS_7 ? 64:0)

//#define APP_SCALE_H ([[UIScreen mainScreen]applicationFrame].size.height/480.0)
//#define APP_SCALE_W ([[UIScreen mainScreen]applicationFrame].size.width/320.0)

// 颜色
#define NavColor 0x012c71

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define GXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//接口///////////////////////////////
#define MAINURL @"http://vip1.yestem.com:8082/cwjk/interface/api.aspx?"
//登录接口
#define URL_Login(user,password)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=login&username=%@&password=%@",user,password]]
//忘记密码接口
#define URL_NewPassword(user,password)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=findpwd&username=%@&password=%@",user,password]]
//注册接口get

#define URl_Register(user,password)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=register&username=%@&password=%@",user,password]]


//搜索文章接口
#define URl_ssjk(keyword) [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=ssjk&key=%@",keyword]]

//第三方注册的接口
#define URl_Threeregister(usid,username,ly)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=threeregister&usid=%@&username=%@&ly=%@",usid,username,ly]]


//第三方登录的接口
#define URl_Threelogin(usid,username,ly) [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=threelogin&usid=%@username=%@&ly=%@",usid,username,ly]]




//图片接口
#define IMAGEURL @"http://vip1.yestem.com:8082/cwjk/upload/images/"
#define URl_Image(imgurl)  [IMAGEURL stringByAppendingString:[NSString stringWithFormat:@"%@",imgurl]]

//首页滚动视图接口
#define URl_Homepage  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=sygd"]]
//首页按钮接口
#define URl_HomepageBtn  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=syan"]]
//左侧按钮接口
#define URl_LeftBtn  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=zcdh"]]


//活动列表接口
#define URL_ActivityList  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=hdlb"]]
//活动详情页
#define URL_ActivityDetail(itemid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=hdnr&itemid=%@",itemid]]

//活动报名
#define URL_Register(username,age,sex,phone,actionid,realname)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=hdbm&username=%@&age=%@&sex=%@&telephone=%@&hdid=%@&realname=%@",username,age,sex,phone,actionid,realname]]


//文章列表栏目1
#define URL_NewsList(nodeid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=wzlb&nodeid=%@",nodeid]]


//文章列表2内容
#define URL_NewsCotentList(nodeid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=wzlbnr&nodeid=%@",nodeid]]
//去做任务列表_栏目
#define URL_TaskNewsList [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=xhdjblm"]]

//文章详情页
#define URL_NewsCotentDetail(itemid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=wzxqnr&itemid=%@",itemid]]


//礼品列表接口
#define URl_PresentList  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=lplb"]]
//礼品详情接口
#define URL_PresentDetail(itemid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=lpxq&itemid=%@",itemid]]

//收货地址接口
#define URL_AdressReceive(username,realname,code,provence,phone,lpid,adress)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=shdz&username=%@&realname=%@&yzbm=%@&shq=%@&telephone=%@&lqid=%@&address=%@",username,realname,code,provence,phone,lpid,adress]]

//这个是个人成就
#define URL_UserAcheive(useid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=grcj&useid=%@",useid]]

//这个是奖励列表
#define URL_UserTask(useid)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=jfzwlb&useid=%@",useid]]

//赚取积分接口
#define URL_EarnAcheive(useid,itemid,jfds)  [MAINURL stringByAppendingString:[NSString stringWithFormat:@"transaction=zqjf&useid=%@&itemid=%@&jfds=%@",useid,itemid,jfds]]

#endif
