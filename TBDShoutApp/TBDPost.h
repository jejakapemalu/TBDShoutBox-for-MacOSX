//
//  TBDPost.h
//  TBDShout
//

#import <Foundation/Foundation.h>

@interface TBDPost : NSObject<NSURLConnectionDelegate>
{

    NSString* url;
    NSString* stringData;
    NSString* username;
    NSString* password;
    NSString* postKey;
    NSString* host;
    NSString* path;
    NSString* status;
    NSString* postFields;
    NSMutableData* responseData;
    NSMutableURLRequest *request;
    NSString* cookie;

}
@property(retain)NSString* username;
@property(retain)NSString* password;
@property(retain)NSString* postKey;
@property(retain)NSString* host;
@property(retain)NSString* path;
@property(retain)NSString* postFields;
@property(retain)NSString* shoutMsg;
@property(retain)NSString* status;
-(void)Logout;
-(void)Login;
-(void)shout;
-(void)SendShout:(NSString*) text;
@end
