# MultipleSelectionCalendar
A simple multiple selection calendar base on FSCalendar.

![alt tag](https://github.com/chunpinglai/MultipleSelectionCalendar/blob/master/Preview.png)


## How To Get Started

+ pod 'FSCalendar'
+ Download Calendar and import it into your project.

## INTERFACE

	@interface CalendarViewController : UIViewController

	@property (strong, nonatomic) NSDateFormatter *dateFormatter;
	@property (strong, nonatomic) NSMutableArray *selectedDays;
	@property (nonatomic, weak) NSObject <CalendarViewControllerDelegate> *calendarViewControllerDelegate;
	@property (nonatomic, strong) UIColor *tintColor;
	- (instancetype)initWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
	@end

## CalendarViewControllerDelegate

@param days return the days as a NSMutableArray which user selected.

	@protocol CalendarViewControllerDelegate
	@required
	- (void)calendarSelectedDays:(NSMutableArray *)days;
	@end

## USAGE
1.Present Calendar  

	CalendarViewController *vc = [[CalendarViewController alloc]initWithTitle:@"Choose Date" doneButtonTitle:@"Done" 	cancelButtonTitle:@"Cancel"];
	vc.calendarViewControllerDelegate = self;
	vc.tintColor = [UIColor blueColor];

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
	navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
	[self presentViewController:navigationController animated:NO completion:nil];

2.Import and add delegate

	#import "CalendarViewController.h"

3.Add delegate

	Add CalendarViewControllerDelegate
    
4.Return the days which user selected.

	- (void)calendarSelectedDays:(NSMutableArray *)days {
	}
