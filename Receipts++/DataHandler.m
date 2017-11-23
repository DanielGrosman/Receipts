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
#import "AddReceiptViewController.h"
#import "Tag+CoreDataClass.h"

@interface DataHandler()
@property (nonatomic, weak) AppDelegate *delegate;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) Tag *tag;
@end

@implementation DataHandler
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = ((AppDelegate*)[[UIApplication sharedApplication] delegate]);
        self.context = self.delegate.persistentContainer.viewContext;
    }
    return self;
}

- (NSArray<Tag*>*)fetchData {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:NO];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tagName == %@", self.tag.tagName];
//    fetchRequest.predicate = predicate;
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    return [self.context executeFetchRequest:fetchRequest error:nil];
}

- (void)saveReceipt:(NSDictionary *)dict {
    
    Receipt *receipt = [[Receipt alloc] initWithContext:self.context];
    receipt.amount = [dict [@"amount"] floatValue];
    receipt.note = dict [@"note"];
    receipt.timeStamp = dict [@"date"];
    
    NSArray <NSString *>*tagsEntered = [dict[@"tagName"] componentsSeparatedByString:@" "];
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:tagsEntered.count];
    for (NSString *tagName in tagsEntered) {
        Tag *tag =[[Tag alloc] initWithContext:self.context];
        tag.tagName = tagName;
        [tags addObject:tag];
        tag.receipts = [NSOrderedSet orderedSetWithObject:receipt];
    }
    [self.delegate saveContext];
}

@end
