//
//  ViewController.m
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/27.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"

#define UIColorFromRGB(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:alphaValue]

#define MY_GREEN_COLOR    UIColorFromRGB(0xC04117, 1.f)

@interface ViewController ()<CalendarViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton:(id)sender {
    //MultipleSelection - A. 多天A.
    //CalendarViewController *vc = [[CalendarViewController alloc]initWithTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"];
    //MultipleSelection - B With selectedDates. 多天B輸入預選天數.
    NSMutableArray *selectedDates = [[NSMutableArray alloc]initWithObjects:@"2017/04/01", nil];
    CalendarViewController *vc = [[CalendarViewController alloc]initWithMode:CalendarMultipleSelection navigationTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" selectedDates:selectedDates dateFormatter:nil];
    
    //SingleSelection 單天
    //CalendarViewController *vc = [[CalendarViewController alloc]initWithMode:CalendarSingleSelection navigationTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" selectedDates:nil dateFormatter:nil];
    
    vc.calendarViewControllerDelegate = self;
    vc.tintColor = MY_GREEN_COLOR;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

- (void)calendarSelectedDays:(NSMutableArray *)days {
    NSLog(@"days:%@",days);
}

@end
