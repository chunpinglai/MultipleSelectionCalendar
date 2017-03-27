//
//  CalendarCell.h
//  TestCalendar
//
//  Created by AbbyLai on 2017/3/24.
//  Copyright © 2017年 AbbyLai. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>

typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
    SelectionTypeLeftBorder,
    SelectionTypeMiddle,
    SelectionTypeRightBorder
};

@interface CalendarCell : FSCalendarCell

@property (weak, nonatomic) UIImageView *circleImageView;
@property (weak, nonatomic) CAShapeLayer *selectionLayer;
@property (assign, nonatomic) SelectionType selectionType;

@end
