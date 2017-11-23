//
//  ViewController.m
//  Receipts++
//
//  Created by Daniel Grosman on 2017-11-23.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ViewController.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "AddReceiptViewController.h"
#import "DataHandler.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<Tag*>*tags;
@property (nonatomic) DataHandler *dataHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataHandler = [DataHandler new];
    [self fetchData];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(fetchData) name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void) fetchData {
    self.tags = [self.dataHandler fetchData];
}

- (void)setTags:(NSArray *)tags {
    _tags = tags;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tags.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags[section].receipts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", self.tags[section].tagName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Tag *tag = self.tags[indexPath.section];
    Receipt *receipt = tag.receipts[indexPath.row];
    cell.infoLabel.text = receipt.note;
    cell.amountLabel.text = [NSString stringWithFormat:@"$%.2f", receipt.amount];
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddReceipt"]) {
        AddReceiptViewController *addReceiptViewController = segue.destinationViewController;
        addReceiptViewController.dataHandler = self.dataHandler;
    }
}


@end
