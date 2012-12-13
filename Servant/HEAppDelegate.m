//
//  HEAppDelegate.m
//  Servant
//
//  Created by Jonathan Dalrymple on 12/12/2012.
//  Copyright (c) 2012 Hello Inc. All rights reserved.
//

#import "HEAppDelegate.h"

#import "HESettingWindowController.h"
#import "HEStatusBarView.h"

@interface HEAppDelegate ()

@property (nonatomic,strong) NSStatusItem *menuBarItem;

@property (nonatomic,strong) HESettingWindowController *settingsController;

@end

@implementation HEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  
  HEStatusBarView *statusBarView = [[HEStatusBarView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 19.0, 19.0)];
  
  self.menuBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  
  [[self menuBarItem] setView:statusBarView];
  
  //Provide the view with a reference so that we handle control events
  [statusBarView setStatusBarItem:[self menuBarItem]];
  
  //Resize the view to force it to render correctly
  //[statusBarView setFrame:NSMakeRect(0.0, 3.5, 15, 15)];
  
  [[self menuBarItem] setMenu:[self menu]];
  
  [self update:nil];
}



#pragma mark - Actions
- (IBAction)showSettings:(id)sender {
  
  HESettingWindowController *settings;
  
  settings = [[HESettingWindowController alloc] initWithWindowNibName:@"SettingsWindow"];
 
  [self setSettingsController:settings];
  
  [settings showWindow:nil];
  
}

- (NSString *)projectName {
  NSString *projectName;
  
  if (!(projectName = [[NSUserDefaults standardUserDefaults] stringForKey:@"jenkins_projectname"])) {
    projectName =  @"Hello-iOS";
  }
  return projectName;
}

- (NSString *)hostName {
  
  NSString *hostname;
  
  //if (!(hostname =[[NSUserDefaults standardUserDefaults] stringForKey:@"jenkins_hostname"]) ) {
    hostname = @"http://localhost:8080";
  //}
  
  return hostname;
}

- (NSURL *)lastBuildEndPointURL {
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@/job/%@/lastBuild/api/json",[self hostName],[self projectName]]];
}

- (IBAction)update:(id)sender {
  
  NSLog(@"%@",[self lastBuildEndPointURL]);
  
  [(HEStatusBarView *)[[self menuBarItem] view] setState:HEStatusBarViewStateLoading];
  
  [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[self lastBuildEndPointURL]]
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                           
                           NSLog(@"%@",error);
                           
                           if (!error) {
                             [self handleResponse:response data:data];
                           }
                           else {
                             //[[self item] setTitle:@"URL Error"];
                           }
                           
                         }];
  
}

- (IBAction)exitApplication:(id)sender {  
  [[NSApplication sharedApplication] terminate:nil];
}

- (void)showNotification:(id)response {
  
  NSUserNotification *notification;
  
  notification = [[NSUserNotification alloc] init];
  
  [notification setTitle:@"Build State"];
  
  [notification setSubtitle:[response valueForKeyPath:@"result"]];
  
  [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

#pragma mark - NSURLConnection
- (void)handleResponse:(NSURLResponse *)aResponse data:(NSData *)aData {
  
  id obj;
  NSError *error = nil;
  
  if (!(obj = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingAllowFragments error:&error])) {
    NSLog(@"JSON Error %@",error);
    return;
  }
  
  //[self showNotification:obj];
  
  //NSLog(@"Response %@",obj);
  
  if ([[[obj valueForKeyPath:@"result"] lowercaseString] isEqualToString:@"success"]) {
    [(HEStatusBarView *)[[self menuBarItem] view] setState:HEStatusBarViewStateSuccess];
  }
  else {
    [(HEStatusBarView *)[[self menuBarItem] view] setState:HEStatusBarViewStateFailure];

  }
  
  [[self statusMenuItem] formatObject:obj];
  
  __unsafe_unretained id weakSelf = self;
  
  //Update again in 5 seconds
  double delayInSeconds = 60.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [weakSelf update:nil];
  });
  
}

@end
