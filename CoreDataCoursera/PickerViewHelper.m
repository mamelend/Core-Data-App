//
//  PickerViewHelper.m
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/28/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import "PickerViewHelper.h"

@interface PickerViewHelper ()

@property (nonatomic) NSMutableArray *pickerData;

@end

@implementation PickerViewHelper

- (id) init {
    if ([super init] == nil) {
        return nil;
    }
    self.pickerData = [NSMutableArray arrayWithArray:@[]];
    return self;
}

- (void) setArray:(NSArray *) incoming {
    self.pickerData = [NSMutableArray arrayWithArray:incoming];
}

- (void) addItemToArray:(NSObject *) newItem {
    [self.pickerData addObject:newItem];
}

- (NSObject *) getItemFromArray:(NSUInteger) index {
    return [self.pickerData objectAtIndex:index];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.pickerData objectAtIndex:row] description];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void) viewDidLoad {
    [super viewDidLoad];
}

@end
