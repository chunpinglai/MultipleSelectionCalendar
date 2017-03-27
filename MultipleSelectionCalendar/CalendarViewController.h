//
//  CalendarViewController.h
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/24.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarViewControllerDelegate;

@interface CalendarViewController : UIViewController

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSMutableArray *selectedDays;
@property (nonatomic, weak) NSObject <CalendarViewControllerDelegate> *calendarViewControllerDelegate;
@property (nonatomic, strong) UIColor *tintColor;
- (instancetype)initWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

@end

@protocol CalendarViewControllerDelegate
@required
- (void)calendarSelectedDays:(NSMutableArray *)days;
@end
