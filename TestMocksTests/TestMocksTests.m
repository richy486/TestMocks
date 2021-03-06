//
//  TestMocksTests.m
//  TestMocksTests
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"
#import "Database.h"
#import "TwitterConnection.h"
#import "TweetView.h"
#import "Tweet.h"
#import "Network.h"
#import "NetworkItems.h"

@interface TestMocksTests : XCTestCase

@end

@implementation TestMocksTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMockClass {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    ViewController *controller = [[ViewController alloc] init];
    
    // create a mock for the user defaults and make sure it's used
    id userDefaultsMock = OCMClassMock([NSUserDefaults class]);
    OCMStub([userDefaultsMock standardUserDefaults]).andReturn(userDefaultsMock);
    
    // call the code under test
    [controller updateUserDefaults];
    
    // verify it has called the expected method
    OCMVerify([userDefaultsMock setObject:@"http://someurl" forKey:@"MyAppURLKey"]);
}

- (void) testPartialMocks {
    
    ViewController *controller = [[ViewController alloc] init];
    
    // create an object and a partial mock for it
    Database *myObject = [[Database alloc] init];
    id myObjectMock = OCMPartialMock(myObject);
    
    // replace (stub) one method on the object
    BOOL returnVal = YES;
    OCMStub([myObjectMock writeToDatabase]).andReturn(returnVal);

    controller.database = myObjectMock;
    
    // call the code under test
    [controller updateDatabase];
    
    // verify that the method has been called
    OCMVerify([myObjectMock writeToDatabase]);
}

- (void)testDisplaysTweetsRetrievedFromConnection
{
    ViewController *controller = [[ViewController alloc] init];
    
    id mockConnection = OCMClassMock([TwitterConnection class]);
    controller.connection = mockConnection;
    
    Tweet *testTweet = [[Tweet alloc] init]; /* create a tweet somehow */;
    NSArray *tweetArray = [NSArray arrayWithObject:testTweet];
    OCMStub([mockConnection fetchTweets]).andReturn(tweetArray);
    
    id mockView = OCMClassMock([TweetView class]);
    controller.tweetView = mockView;
    
    [controller updateTweetView];
    
    OCMVerify([mockView addTweet:[OCMArg any]]);
    OCMVerify([mockView addTweet:testTweet]);
}

- (void) testNetworkItems {
    
    NetworkItems *networkItems = [[NetworkItems alloc] init];
    id networkItemsPartialMock = OCMPartialMock(networkItems);
    
    id responseMock = @{@"name": @"bruce"};
    
    OCMStub([networkItemsPartialMock get:[OCMArg any]
                              parameters:[OCMArg any]
                           completeBlock:[OCMArg any]
                               failBlock:[OCMArg any]]).andDo(^(NSInvocation *invocation) {
        void (^complete)(Network *network, id response);
        [invocation getArgument: &complete atIndex: 4];
        complete(networkItemsPartialMock, responseMock);
    });
    
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Will complete block"];
    
    [networkItemsPartialMock getItems:@"api.website.com"
                     count:100
             completeBlock:^(Network * _Nonnull network, id  _Nullable response) {
                 NSLog(@"complete");
                 
                 NSDictionary *dict = (NSDictionary*)response;
                 XCTAssert(dict);
                 
                 NSString *name = dict[@"name"];
                 XCTAssert(name);
                 
                 XCTAssert([name isEqualToString:@"bruce"]);
                 
                 
                 [expectation fulfill];
             } failBlock:^(Network * _Nonnull network, NSError * _Nullable error) {
                 NSLog(@"fail");
             }];
    
    OCMVerify([networkItemsPartialMock get:[OCMArg any]
                                parameters:[OCMArg any]
                             completeBlock:[OCMArg invokeBlock]
                                 failBlock:[OCMArg invokeBlock]]);
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
