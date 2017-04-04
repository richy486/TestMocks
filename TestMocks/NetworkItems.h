//
//  NetworkItems.h
//  TestMocks
//
//  Created by Richard Adem on 3/4/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

#import "Network.h"

@interface NetworkItems : Network

- (void) getItems: (NSString*_Nonnull) itemType
  count: (NSInteger) count
completeBlock: (void (^_Nullable)(Network * _Nonnull network, id _Nullable response)) complete
        failBlock: (void (^_Nullable)(Network * _Nonnull network, NSError * _Nullable error)) fail;

@end
