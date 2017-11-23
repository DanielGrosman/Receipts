//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Daniel Grosman on 2017-11-23.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "AddReceiptViewController.h"

@interface AddReceiptViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *addNoteTextField;
@property (weak, nonatomic) IBOutlet UITextField *addTagsTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *addTimeStampDatePicker;


@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)receiptSaved:(UIButton *)sender {
    NSString *amountText = self.addAmountTextField.text;
    NSString *noteText = self.addNoteTextField.text;
    NSString *tagsText = self.addTagsTextField.text;
    NSDate *datePicked = self.addTimeStampDatePicker.date;
    NSDictionary *data = @{@"amount":amountText,@"note":noteText,@"tagName":tagsText,@"date":datePicked};
    [self.dataHandler saveReceipt:data];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
