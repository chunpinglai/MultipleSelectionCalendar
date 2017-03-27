//
//  ViewController.m
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/27.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"

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
    CalendarViewController *vc = [[CalendarViewController alloc]initWithTitle:@"Choose Date" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"];
    vc.calendarViewControllerDelegate = self;
    vc.tintColor = [UIColor blueColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

- (void)calendarSelectedDays:(NSMutableArray *)days {
    NSLog(@"days:%@",days);
}

@end
