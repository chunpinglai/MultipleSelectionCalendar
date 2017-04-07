//
//  CalendarViewController.h
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/24.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CalendarSelectionMode) {
    CalendarMultipleSelection,
    CalendarSingleSelection
};

@protocol CalendarViewControllerDelegate;

@interface CalendarViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *selectedDays;
@property (nonatomic, weak) NSObject <CalendarViewControllerDelegate> *calendarViewControllerDelegate;
@property (nonatomic, strong) UIColor *tintColor;
- (instancetype)initWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
- (instancetype)initWithMode:(CalendarSelectionMode)selectionMode navigationTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle selectedDates:(NSMutableArray *)selectedDates dateFormatter:(NSDateFormatter *)dateFormatter;
@end

@protocol CalendarViewControllerDelegate
@required
- (void)calendarSelectedDays:(NSMutableArray *)days;
@end
