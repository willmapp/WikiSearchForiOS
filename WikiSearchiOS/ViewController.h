//
//  ViewController.h
//  WikiSearchiOS
//
//  Created by William Lee Mapp, III on 7/12/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString *m_selectedLink;
}
@property (nonatomic, strong) IBOutlet UITextField  *searchField;
@property (nonatomic, strong) IBOutlet UIButton     *searchButton;

- (IBAction) searchButtonTapped:(id)sender;

@end

