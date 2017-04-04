//
//  Network.m
//  TestMocks
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import "Network.h"

@implementation Network

- (void) get: (NSString* _Nonnull) url
  parameters: (NSDictionary* _Nullable) parameters
completeBlock: (void (^_Nullable)(Network * _Nonnull network, id _Nullable response)) complete
   failBlock: (void (^_Nullable)(Network * _Nonnull network, NSError * _Nullable error)) fail {
    
    fail(self, [NSError errorWithDomain:@"code" code:999 userInfo:nil]);
    
}

@end
