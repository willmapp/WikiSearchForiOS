//
//  WebViewController.h
//  WikiSearchiOS
//
//  Created by William Lee Mapp, III on 7/12/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, strong) NSString  *url;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@end
