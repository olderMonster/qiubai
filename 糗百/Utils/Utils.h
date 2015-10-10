//
//  Utils.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#ifndef Utils_h
#define Utils_h

//颜色取值
#define kColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kColorRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设备尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kBaseUrl @"http://m2.qiushibaike.com/article/"

// http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)  最热
//http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)    最新
//http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)   图文
//http://m2.qiushibaike.com/article/\(self.jokeId)/comments?count=20&page=\(self.page)


#endif /* Utils_h */
