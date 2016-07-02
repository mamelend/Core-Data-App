//
//  ViewController.m
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/27/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChoreMO.h"
#import "PersonMO.h"
#import "ChoreLogMO.h"
#import "PickerViewHelper.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *choreField;
@property (weak, nonatomic) IBOutlet UITextField *personField;

@property (weak, nonatomic) IBOutlet UILabel *persistedData;
@property (weak, nonatomic) IBOutlet UILabel *coreDataCount;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UIPickerView *choreRoller;
@property (nonatomic) PickerViewHelper *choreRollerHelper;

@property (weak, nonatomic) IBOutlet UIPickerView *personRoller;
@property (nonatomic) PickerViewHelper *personRollerHelper;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.choreRollerHelper = [[PickerViewHelper alloc]init];
    self.personRollerHelper = [[PickerViewHelper alloc]init];
    
    [self.choreRoller setDelegate:self.choreRollerHelper];
    [self.choreRoller setDataSource:self.choreRollerHelper];
    
    [self.personRoller setDelegate:self.personRollerHelper];
    [self.personRoller setDataSource:self.personRollerHelper];
    
    [self updateChoreRoller];
    [self updatePersonRoller];
    [self updateLogList];
    [self updateCoreDataCount];
}

- (IBAction)addChoreButtonPressed:(id)sender {
    ChoreMO *c = [self.appDelegate createChoreMO];
    c.chore_name = self.choreField.text;
    [self.appDelegate saveContext];
    [self updateChoreRoller];
    [self updateLogList];
    [self updateCoreDataCount];
}

- (IBAction)addPersonButtonPressed:(id)sender {
    PersonMO *p = [self.appDelegate createPersonMO];
    p.person_name = self.personField.text;
    [self.appDelegate saveContext];
    [self updatePersonRoller];
    [self updateCoreDataCount];
}

- (IBAction)choreLogButtonPressed:(id)sender {
    
    NSInteger choreRow = [self.choreRoller selectedRowInComponent:0];
    NSInteger personRow = [self.personRoller selectedRowInComponent:0];
    
    ChoreMO *chore = (ChoreMO *)[self.choreRollerHelper getItemFromArray:choreRow];
    PersonMO *person = (PersonMO *)[self.personRollerHelper getItemFromArray:personRow];
    
    ChoreLogMO *choreLog = [self.appDelegate createChoreLogMO];
    choreLog.person_who_did_it = person;
    choreLog.chore_done = chore;
    choreLog.when = [self.datePicker date];

    [self.appDelegate saveContext];
    [self updateLogList];
    [self updateCoreDataCount];
}

- (IBAction)deleteChoreButtonPressed:(id)sender {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Chore Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreMO *c in results) {
        [moc deleteObject:c];
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    error = nil;
    results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Person Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (PersonMO *p in results) {
        [moc deleteObject:p];
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    error = nil;
    results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching ChoreLog Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreLogMO *cl in results) {
        [moc deleteObject:cl];
    }
    
    [self.appDelegate saveContext];
    [self updateChoreRoller];
    [self updatePersonRoller];
    [self updateLogList];
    [self updateCoreDataCount];
}

- (void) updateLogList {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching ChoreLog Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    for (ChoreLogMO *cl in results) {
        [buffer appendFormat:@"\n%@",cl, nil];
    }
    self.persistedData.text = buffer;
}

- (void) updateChoreRoller {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Chore Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    NSMutableArray *choreData = [NSMutableArray arrayWithArray:@[]];
    for (ChoreMO *c in results) {
        [choreData addObject:c];
    }
    [self.choreRollerHelper setArray:choreData];
    [self.choreRoller reloadAllComponents];
}

- (void) updatePersonRoller {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Person Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    NSMutableArray *personData = [NSMutableArray arrayWithArray:@[]];
    for (PersonMO *p in results) {
        [personData addObject:p];
    }
    [self.personRollerHelper setArray:personData];
    [self.personRoller reloadAllComponents];
}

- (void) updateCoreDataCount {
    int count = 0;
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Chore Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreMO *c in results) {
        count +=1;
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    error = nil;
    results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching Person Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (PersonMO *p in results) {
        count +=1;
    }
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
    error = nil;
    results = [moc executeFetchRequest:request error: &error];
    if (!results) {
        NSLog(@"Error fetching ChoreLog Objects:%@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreLogMO *cl in results) {
        count +=1;
    }
    
    self.coreDataCount.text = [NSString stringWithFormat:@"%d items in Core Data.", count];

}

@end