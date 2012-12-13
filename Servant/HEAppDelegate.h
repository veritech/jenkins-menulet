//
//  HEAppDelegate.h
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HEStatusMenuItem.h"

@interface HEAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic,weak) IBOutlet NSMenu *menu;
@property (weak) IBOutlet  HEStatusMenuItem *statusMenuItem;

- (IBAction)showSettings:(id)sender;

- (IBAction)update:(id)sender;

- (IBAction)exitApplication:(id)sender;

@end
