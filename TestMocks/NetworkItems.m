//
//  NetworkItems.m
//  TestMocks
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import "NetworkItems.h"

@implementation NetworkItems

- (void) getItems: (NSString*_Nonnull) itemType
            count: (NSInteger) count
    completeBlock: (void (^_Nullable)(Network * _Nonnull network, id _Nullable response)) complete
        failBlock: (void (^_Nullable)(Network * _Nonnull network, NSError * _Nullable error)) fail {
    
    [self get:@"api.items.com" parameters:nil completeBlock:^(Network * _Nonnull network, id  _Nullable response) {
        if (response) {
            complete(self, response);
        } else {
            fail(self, [NSError errorWithDomain:@"items" code:923 userInfo:nil]);
        }
    } failBlock:^(Network * _Nonnull network, NSError * _Nullable error) {
        fail(network, error);
    }];
}

@end
