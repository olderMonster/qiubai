//
//  HostestViewController.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QBHostestApiManager.h"

@interface HostestViewController : UIViewController<QBAPIManagerApiCallBackDelegate , QBAPIManagerInterceptor>

@end
