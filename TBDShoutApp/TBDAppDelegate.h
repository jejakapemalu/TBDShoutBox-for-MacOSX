//
//  TBDAppDelegate.h
//  TBDShoutApp
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "TBDPost.h"
@interface TBDAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSButton* shoutButton;
    TBDPost* post;
    IBOutlet NSTextField* shoutTextField;
    IBOutlet NSView* loginForm;
    IBOutlet NSView* mainView;
    IBOutlet NSView* rootView;
    IBOutlet NSTextField* loginUsername;
    IBOutlet NSTextField* loginPassword;
    IBOutlet NSTextField* loginStatus;
    IBOutlet WebView* shoutView;
}
@property (assign) IBOutlet NSWindow *window;
-(IBAction)shoutPost:(id)sender;
-(IBAction)getLoginForm:(id)sender;
@end
