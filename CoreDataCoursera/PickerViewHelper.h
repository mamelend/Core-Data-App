//
//  PickerViewHelper.h
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/28/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewHelper : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (void) setArray:(NSArray *) incoming;
- (void) addItemToArray:(NSObject *) newItem;
- (NSObject *) getItemFromArray:(NSUInteger) index;

@end