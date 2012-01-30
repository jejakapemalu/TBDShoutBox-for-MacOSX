//
//  TBDAppDelegate.m
//  TBDShoutApp
//
#import "TBDAppDelegate.h"
#define CHAT_URL @"http://s.tbd.my:8080/tbdv2.html"
@implementation TBDAppDelegate

@synthesize window = _window;

-(void)openLoginForm
{
    if ([rootView.subviews count])
        [[rootView.subviews lastObject]removeFromSuperview];
    [rootView addSubview:loginForm];
}
-(void)openWebView
{
    [rootView replaceSubview:loginForm with:mainView];
    [[shoutView mainFrame]loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CHAT_URL]]];
    
}
-(IBAction)getLoginForm:(id)sender
{
    [post setUsername:[loginUsername stringValue]];
    [post setPassword:[loginPassword stringValue]];
    if (![post.username isEqualToString:@""]&&![post.password isEqualToString:@""])
        [post Login];
    NSLog(@"%@",[post status]);
    ([[post status] isEqualToString:@"success"])?[self openWebView]:[loginStatus setStringValue:@"Login Failed!"];
}
-(IBAction)shoutPost:(id)sender
{
//    NSLog(@"%@",[shoutTextField stringValue]);
    [post SendShout:[shoutTextField stringValue]];
    [shoutTextField setStringValue:@""];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    post = [[TBDPost alloc]init];
    [post setHost:@"http://w3.tbd.my"];
    [post setPath: @"/"];
    [self openLoginForm];

}
@end
