//
//  ViewController.h
//  TestMocks
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TwitterConnection;
@class TweetView;

@interface ViewController : UIViewController

- (void) updateUserDefaults;
- (void) updateDatabase;

@property(retain) TwitterConnection *connection;
@property(retain) TweetView *tweetView;

- (void)updateTweetView;

@end

