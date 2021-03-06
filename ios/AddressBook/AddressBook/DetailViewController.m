//
//  DetailViewController.m
//  AddressBook
//
//  Created by 藤田 泰介 on 11/11/12.
//  Copyright (c) 2011 Commonsense. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize detailItem = _detailItem;
@synthesize scrollView = _scrollView;
@synthesize nameField = _nameField;
@synthesize zipCodeField = _zipCodeField;
@synthesize stateField = _stateField;
@synthesize cityField = _cityField;
@synthesize otherField = _otherField;
@synthesize masterPopoverController = _masterPopoverController;


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem; 

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    [self becomeFirstResponder];
    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.zipCodeField.text = self.detailItem.address.zipCode;
        self.stateField.text = self.detailItem.address.state;
        self.cityField.text = self.detailItem.address.city;
        self.otherField.text = self.detailItem.address.other;
    } else {
        self.nameField.text = nil;
        self.zipCodeField.text = nil;
        self.stateField.text = nil;
        self.cityField.text = nil;
        self.otherField.text = nil;
    }
}

- (void)done
{
    if (!self.detailItem) {
        _detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) 
                                                    inManagedObjectContext:self.managedObjectContext];
        _detailItem.address = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Address class]) 
                                                            inManagedObjectContext:self.managedObjectContext];
    }
    self.detailItem.name = self.nameField.text;
    self.detailItem.address.zipCode = self.zipCodeField.text;
    self.detailItem.address.state = self.stateField.text;
    self.detailItem.address.city = self.cityField.text;
    self.detailItem.address.other = self.otherField.text;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                            target:self 
                                                                                            action:@selector(done)];
    self.scrollView.contentSize = CGSizeMake(320, 800);
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scrollView = nil;
    self.nameField = nil;
    self.zipCodeField = nil;
    self.stateField = nil;
    self.cityField = nil;
    self.otherField = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
