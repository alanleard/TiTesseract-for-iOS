/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "NetAppiosTitesseractModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "Tesseract.h"

@implementation NetAppiosTitesseractModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"57ce4b28-5733-4c02-be07-11dfc7f1ef1f";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"net.appios.titesseract";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	Tesseract* tesseract = [Tesseract alloc];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)recognizedText:(id)args
{
	NSString *lang = [TiUtils stringValue:[args objectAtIndex:1]];
	NSString *whitelist = [TiUtils stringValue:[args objectAtIndex:2]];

	Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:lang];
	[tesseract setVariableValue:whitelist forKey:@"tessedit_char_whitelist"];

	UIImage *ocrImage = [[args objectAtIndex:0] image];
	[tesseract setImage:ocrImage];
	[tesseract recognize];

	NSString *recognizedText = [tesseract recognizedText];
	[tesseract clear];

	return recognizedText;
}


-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end
