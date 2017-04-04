//
//  ViewController.m
//  TestMocks
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import "ViewController.h"
#import "Database.h"
#import "TwitterConnection.h"
#import "TweetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.database = [[Database alloc] init];
    self.tweetView = [[TweetView alloc] init];
}

- (void) updateUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:@"http://someurl" forKey:@"MyAppURLKey"];
}

- (void) updateDatabase {
    BOOL didWrite = [self.database writeToDatabase];
    NSLog(@"did write: %d", didWrite);
}

- (void)updateTweetView {
    NSArray *tweets = [self.connection fetchTweets];
    if (tweets != nil) {
        for (Tweet *t in tweets) {
            [self.tweetView addTweet:t];
        }
    } else {
        /* handle error cases */
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
