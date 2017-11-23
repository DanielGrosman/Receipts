//
//  DataHandler.h
//  Receipts++
//
//  Created by Daniel Grosman on 2017-11-23.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag+CoreDataClass.h"

@interface DataHandler : NSObject

- (NSArray<Tag*>*)fetchData;
- (void)saveReceipt:(NSDictionary *)dict;

@end
