//
//  DetailViewController.h
//  AddressBook
//
//  Created by 藤田 泰介 on 12/07/22.
//  Copyright (c) 2012 Revolution 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *detailItem;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeField;
@property (strong, nonatomic) IBOutlet UITextField *stateField;
@property (strong, nonatomic) IBOutlet UITextField *cityField;
@property (strong, nonatomic) IBOutlet UITextField *otherField;

@end
