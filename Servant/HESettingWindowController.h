//
//  HESettingWindowController.h
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HESettingWindowController : NSWindowController

@property (weak) IBOutlet NSPopUpButton *intervalPopup;


- (IBAction)closeWindow:(id)sender;

@end
