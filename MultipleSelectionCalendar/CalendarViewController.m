//
//  CalendarViewController.m
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/24.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCell.h"
#import <FSCalendar.h>

#define defaultNavigationTintColor [UIColor blueColor]
static NSString *const defaultDoneButtonTitle = @"Done";
static NSString *const defaultCancelButtonTitle = @"Cancel";

@interface CalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@property (nonatomic, copy) NSString *doneButtonTitle;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, assign) CalendarSelectionMode calendarSelectionMode;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation CalendarViewController

- (instancetype)initWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    if (self = [self init]) {
        self = [self initWithMode:CalendarMultipleSelection navigationTitle:title doneButtonTitle:doneButtonTitle cancelButtonTitle:cancelButtonTitle selectedDates:nil dateFormatter:nil];
    }
    return self;
}

- (instancetype)initWithMode:(CalendarSelectionMode)selectionMode navigationTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle selectedDates:(NSMutableArray *)selectedDates dateFormatter:(NSDateFormatter *)dateFormatter {
    if (self = [self init]) {
        self.navigationItem.title = title;
        
        if (cancelButtonTitle) {
            _cancelButtonTitle = cancelButtonTitle;
        }
        else {
            _cancelButtonTitle = defaultCancelButtonTitle;
        }
        
        if (doneButtonTitle) {
            _doneButtonTitle = doneButtonTitle;
        }
        else {
            _doneButtonTitle = defaultDoneButtonTitle;
        }
        
        _calendarSelectionMode = selectionMode;
        
        if (dateFormatter) {
            _dateFormatter = dateFormatter;
        }
        else {
            [self addDefaultDateFormatter];
        }
        
        if (selectedDates) {
            if (_calendarSelectionMode == CalendarSingleSelection) {
                //CalendarSingleSelection只抓第一個值
                _selectedDays = [[NSMutableArray alloc]initWithObjects:[selectedDates objectAtIndex:0], nil];
            }
            else {
                _selectedDays = [[NSMutableArray alloc]initWithArray:selectedDates];
            }
        }
        else {
            _selectedDays = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationColor:_tintColor];
    [self.calendar layoutIfNeeded];
    
//    if (_selectedDays && (_calendarSelectionMode == CalendarMultipleSelection)) {
       for (NSString *dateStr in _selectedDays) {
            NSDate *date = [_dateFormatter dateFromString:dateStr];
            [self.calendar selectDate:date scrollToDate:NO];
        }
        [self configureVisibleCells];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,  64, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.allowsMultipleSelection = YES;
    [view addSubview:calendar];
    self.calendar = calendar;
    
//    calendar.calendarHeaderView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
//    calendar.calendarWeekdayView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    calendar.calendarHeaderView.backgroundColor = [UIColor whiteColor];
    calendar.calendarWeekdayView.backgroundColor = [UIColor whiteColor];
    calendar.appearance.weekdayTextColor = _tintColor;
    calendar.appearance.headerTitleColor = _tintColor;
    calendar.appearance.titleTodayColor = [UIColor redColor];
//    calendar.appearance.eventSelectionColor = [UIColor whiteColor];
//    calendar.appearance.eventOffset = CGPointMake(0, -7);
//    calendar.today = [NSDate date]; // Hide the today circle
    [calendar registerClass:[CalendarCell class] forCellReuseIdentifier:@"CalendarCell"];
    
    UIPanGestureRecognizer *scopeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:calendar action:@selector(handleScopeGesture:)];
    [calendar addGestureRecognizer:scopeGesture];
    
    [self initNavigationBar];
}

#pragma mark -

- (void)addDefaultDateFormatter {
    if (!_dateFormatter) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy/MM/dd";
    }
}

- (void)setNavigationColor:(UIColor *)color {
    if (!color) {
        color = defaultNavigationTintColor;
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:color}];
    self.navigationItem.leftBarButtonItem.tintColor = color;
    self.navigationItem.rightBarButtonItem.tintColor = color;
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    if (dateFormatter) {
        _dateFormatter = dateFormatter;
    }
}

- (void)initNavigationBar {
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_cancelButtonTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    [leftBarButtonItem setTarget:self];
    [leftBarButtonItem setAction:@selector(closeView)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_doneButtonTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    [rightBarButtonItem setTarget:self];
    [rightBarButtonItem setAction:@selector(doneButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonAction {
    [self closeView];
    if(_calendarViewControllerDelegate != nil && [_calendarViewControllerDelegate respondsToSelector:@selector(calendarSelectedDays:)]) {
        [_calendarViewControllerDelegate calendarSelectedDays:_selectedDays];
    }
}

#pragma mark - FSCalendarDataSource

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    return [self.dateFormatter dateFromString:@"2016-07-08"];
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
//{
//    return [self.dateFormatter dateFromString:@"2017-03-31"];
//}
//
//- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
//{
//    return nil;
//}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    CalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"CalendarCell" forDate:date atMonthPosition:monthPosition];
    cell.selectionLayer.fillColor = _tintColor.CGColor;
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    return 0;
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    if (_calendarSelectionMode == CalendarSingleSelection) {
        if (_selectedDays.count > 0) {
            NSString *deSelectDateStr = [_selectedDays objectAtIndex:0];
            NSDate *deSelectDate = [_dateFormatter dateFromString:deSelectDateStr];
            [_calendar deselectDate:deSelectDate];
            [_selectedDays removeObject:deSelectDateStr];
        }
    }
    
    [_selectedDays addObject:dateStr];
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    [_selectedDays removeObject:dateStr];
    [self configureVisibleCells];
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    //    if ([self.gregorian isDateInToday:date]) {
    //        return @[[UIColor orangeColor]];
    //    }
    return @[appearance.eventDefaultColor];
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    CalendarCell *diyCell = (CalendarCell *)cell;
    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent) {
        
        SelectionType selectionType = SelectionTypeNone;
        if ([self.calendar.selectedDates containsObject:date]) {
            if ([self.calendar.selectedDates containsObject:date]) {
                selectionType = SelectionTypeSingle;
            }
        } else {
            selectionType = SelectionTypeNone;
        }
        
        if (selectionType == SelectionTypeNone) {
            diyCell.selectionLayer.hidden = YES;
            return;
        }
        
        diyCell.selectionLayer.hidden = NO;
        diyCell.selectionType = selectionType;
        
    } else {
        
        diyCell.circleImageView.hidden = YES;
        diyCell.selectionLayer.hidden = YES;
        
    }
}

@end
