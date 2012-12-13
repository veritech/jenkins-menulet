//
//  HESettingWindowController.m
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import "HESettingWindowController.h"

@interface HESettingWindowController ()

@end

@implementation HESettingWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (IBAction)closeWindow:(id)sender {
  [self close];
}



@end
