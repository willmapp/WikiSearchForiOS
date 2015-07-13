//
//  ViewController.m
//  WikiSearchiOS
//
//  Created by William Lee Mapp, III on 7/12/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

#define GCSAPI_ENDPOINT                     @"https://www.googleapis.com/customsearch/v1?key%@&cx=%@&q=%@"
#define GOOGLE_SEARCH_API_KEY               @"AIzaSyBs7unIlIWBJqljYbfzss9kNYSZ5jKpSO0" // @"AIzaSyC6m-rxkjHxrBObzGmx2CEb64c-12VWW6I" // @"AIzaSyBs7unIlIWBJqljYbfzss9kNYSZ5jKpSO0"
#define GOOGLE_SEARCH_ENGINE_ID             @"001296046484476294385:zq7iayl0vl4"

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchButton;
@synthesize searchField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"PUSH_FROM_SEARCH"])
    {
        WebViewController  *wvc    = segue.destinationViewController;
        
        if(m_selectedLink != NULL)
        {
            // set the next view's url with the link we found from search
            wvc.url = m_selectedLink;
        }
    }
}

- (IBAction) searchButtonTapped:(id)sender
{
    // replace any spaces in the query with percent escapes
    NSString *searchQuery = [searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *searchURL = [[NSString alloc] initWithFormat:GCSAPI_ENDPOINT, GOOGLE_SEARCH_API_KEY, GOOGLE_SEARCH_ENGINE_ID, searchQuery, nil];
    // hit the url and pull the results back
    NSURL *url = [NSURL URLWithString:searchURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if (error != nil)
        {
            NSLog(@"error:%@", error.localizedDescription);
        }
        else
        {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Response String: %@", responseString);
            
            if(responseString != nil)
            {
                // create a dictionary based upon the results
                // get a dictionary
                NSError        *error  = NULL;
                NSDictionary   *dict   = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&error];
                NSArray        *items  = [dict objectForKey:@"items"];
                
                if(items != nil && items.count > 0)
                {
                    // get the first item out of the list
                    NSDictionary *item = [items objectAtIndex:0];
                    // pull out the link
                    m_selectedLink = [[NSString alloc] initWithString:[item objectForKey:@"link"]];
                    // and now segue to the next screen
                    [self performSegueWithIdentifier:@"PUSH_FROM_SEARCH" sender:self];
                }
            }
            else
            {
                NSLog(@"Couldn't Decode JSON");
            }

        }
    }];
}

@end
