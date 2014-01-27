//
//  ViewController.m
//  iLED
//
//  Created by George White on 10/24/11.
//
//  Copyright (c) 2011 Stonehippo Code & Consulting. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "ViewController.h"

@interface ViewController (Private)
- (void) setBrightnessOfLed:(int)lightLevel;
@end

@implementation ViewController
@synthesize brightness;
@synthesize level;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup the serial cable manager
    rscMgr = [[RscMgr alloc] init];
    [rscMgr setDelegate:self];
    [rscMgr setBaud:57600];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBrightness:nil];
    [self setLevel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) setBrightnessOfLed:(int)lightLevel;
{
    // map the incoming light level value (an in from 0-255) to a float
    float flevel = (float)lightLevel / 255;
    level.text = [NSString stringWithFormat:@"%d", lightLevel];
    brightness.alpha = flevel;
}

#pragma mark RscMgrDelegate methods
// Redpark Serial Cable has been connected and/or application moved to foreground.
// protocol is the string which matched from the protocol list passed to initWithProtocol:
- (void) cableConnected:(NSString *)protocol;
{
    [rscMgr setBaud:9600];
    [rscMgr open];
}

// Redpark Serial Cable was disconnected and/or application moved to background
- (void) cableDisconnected;
{
    
}

// serial port status has changed
// user can call getModemStatus or getPortStatus to get current state
- (void) portStatusChanged;
{
    
}

// bytes are available to be read (user calls read:)
- (void) readBytesAvailable:(UInt32)length;
{
    [rscMgr read:rxBuffer Length:length];
    NSString *string = nil;
    
    for (int i = 0; i < length; ++i) {
        if (string) {
            string = [NSString stringWithFormat:@"%@%c", string, ((char *)rxBuffer)[i]];
        } else {
            string = [NSString stringWithFormat:@"%c", ((char *)rxBuffer)[i]];
        }
        [self setBrightnessOfLed:[string intValue]];
        
    }
}



@end
