# MultipleSelectionCalendar
A simple multiple selection calendar base on FSCalendar, also support single selection mode.

![alt tag](https://github.com/chunpinglai/MultipleSelectionCalendar/blob/master/Preview.png)


## How To Get Started

+ pod 'FSCalendar'
+ Download Calendar and import it into your project.

## INTERFACE

	typedef NS_ENUM(NSUInteger, CalendarSelectionMode) {
    CalendarMultipleSelection,
    CalendarSingleSelection
	};
	@interface CalendarViewController : UIViewController

	@property (strong, nonatomic) NSDateFormatter *dateFormatter;
	@property (strong, nonatomic) NSMutableArray *selectedDays;
	@property (nonatomic, weak) NSObject <CalendarViewControllerDelegate> *calendarViewControllerDelegate;
	@property (nonatomic, strong) UIColor *tintColor;
	- (instancetype)initWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
	- (instancetype)initWithMode:(CalendarSelectionMode)selectionMode navigationTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle selectedDates:(NSMutableArray *)selectedDates dateFormatter:(NSDateFormatter *)dateFormatter;
	@end

## CalendarViewControllerDelegate

@param days return the days as a NSMutableArray which user selected.

	@protocol CalendarViewControllerDelegate
	@required
	- (void)calendarSelectedDays:(NSMutableArray *)days;
	@end

## USAGE
1.Create Calendar
#####MultipleSelection - A. [多天A.]

	CalendarViewController *vc = [[CalendarViewController alloc]initWithTitle:@"Choose Date" doneButtonTitle:@"Done" 	cancelButtonTitle:@"Cancel"];
	vc.calendarViewControllerDelegate = self;
	vc.tintColor = [UIColor blueColor];

#####MultipleSelection - B with selectedDates. [多天B 輸入預選天數.]

	NSMutableArray *selectedDates = [[NSMutableArray alloc]initWithObjects:@"2017/04/01", nil];
    
    CalendarViewController *vc = [[CalendarViewController alloc]initWithMode:CalendarMultipleSelection navigationTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" selectedDates:selectedDates dateFormatter:nil];
    vc.calendarViewControllerDelegate = self;
	vc.tintColor = [UIColor blueColor];
    
#####SingleSelection 單天
    
    CalendarViewController *vc = [[CalendarViewController alloc]initWithMode:CalendarSingleSelection navigationTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" selectedDates:nil dateFormatter:nil];

2.Present Calendar  

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
	navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
	[self presentViewController:navigationController animated:NO completion:nil];

3.Import and add delegate

	#import "CalendarViewController.h"

4.Add delegate

	Add CalendarViewControllerDelegate
    
5.Return the days which user selected.

	- (void)calendarSelectedDays:(NSMutableArray *)days {
	}
