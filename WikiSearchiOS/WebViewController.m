//
//  WebViewController.m
//  WikiSearchiOS
//
//  Created by William Lee Mapp, III on 7/12/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController
@synthesize url;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // format the url
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:nsurl];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
