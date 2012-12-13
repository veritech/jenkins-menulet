//
//  HEStatusMenuItem.m
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import "HEStatusMenuItem.h"
#import <QuartzCore/QuartzCore.h>

@interface HEStatusMenuItem ()

@property (nonatomic,strong,readwrite) NSDateFormatter *dateFormatter;

@end

@implementation HEStatusMenuItem

- (void)awakeFromNib {
  
  [super awakeFromNib];
  
}

- (NSDateFormatter *)dateFormatter {
  
  if (!_dateFormatter) {
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"dd/MM/yy @ HH:mm"];
  }
  return _dateFormatter;
}

- (void) formatObject:(id) obj {
  
  NSDate *timestamp;
  NSString *buildStr;
  
  timestamp = [NSDate dateWithTimeIntervalSince1970:[[obj valueForKeyPath:@"timestamp"] intValue]];
  
  buildStr = [NSString stringWithFormat:@"Build #%d - %@",
              [[obj valueForKeyPath:@"number"] intValue],
              [obj valueForKeyPath:@"result"]
   ];
  
  [[self buildLabel] setStringValue:buildStr];
  
  [[self dateLabel] setStringValue:[[self dateFormatter] stringFromDate:timestamp]];
}

@end
