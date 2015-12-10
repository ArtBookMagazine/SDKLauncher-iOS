//
//  BaseViewController.m
//  SDKLauncher-iOS
//
//  Created by Shane Meyer on 2/1/13.
//  Copyright (c) 2014 Readium Foundation and/or its licensees. All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice, this 
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  3. Neither the name of the organization nor the names of its contributors may be 
//  used to endorse or promote products derived from this software without specific 
//  prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.

#import "BaseViewController.h"


@implementation BaseViewController


- (void)cleanUp {
}


- (void)dealloc {
	[self cleanUp];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];

	if (self.isViewLoaded && !m_visible) {
		self.view = nil;
		[self cleanUp];
	}
}


- (id)initWithTitle:(NSString *)title navBarHidden:(BOOL)navBarHidden {
	m_navBarHidden = navBarHidden;

	if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
	}

	return self;
}


- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	m_visible = NO;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	m_visible = YES;
	UINavigationController *navController = self.navigationController;

	if (navController != nil) {
		[navController setNavigationBarHidden:m_navBarHidden animated:NO];
	}
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message, ... {
    va_list args;
    va_start(args, message);
    message = [[NSString alloc] initWithFormat:message arguments:args];
    va_end(args);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
