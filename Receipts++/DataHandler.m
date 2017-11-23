//
//  DataHandler.m
//  Receipts++
//
//  Created by Daniel Grosman on 2017-11-23.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "DataHandler.h"
#import "Receipt+CoreDataClass.h"
#import "AppDelegate.h"

@interface DataHandler()
@property (nonatomic, weak) AppDelegate *delegate;
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation DataHandler

- (NSArray<Tag*>*)fetchData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (void)saveReceipt:(NSDictionary *)dict {
    Receipt *newReceipt = [[Receipt alloc] initWithContext:self.context];
    newReceipt.amount = [dict [@"amount"] floatValue];
    newReceipt.note = dict [@"note"];
    newReceipt.timeStamp = dict [@"date"];
    NSArray <NSString *>*tagsEntered = [dict[@"tags"] componentsSeparatedByString:@" "];
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:tagsEntered.count];
    for (NSString *tagName in tagsEntered) {
        Tag *tag =[[Tag alloc] initWithContext:self.context];
        tag.tagName = tagName;
        [tags addObject:tag];
    }
    newReceipt.tags = [NSOrderedSet orderedSetWithArray:tags];
    [self.delegate saveContext];
}

@end
