//
//  TBDPost.m
//  TBDShout
//
#import "TBDPost.h"

#define httpHeader "GET %s HTTP/1.1\r\nHost: %s\r\nConnection: keep-alive\r\nX-Requested-With: XMLHttpRequest\r\nIf-None-Match: 0\r\nIf-Modified-Since: %s\r\n\r\n"

#define USERAGENT "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.6) Gecko/20100625 Firefox/3.6.6 ( .NET CLR 3.5.30729; .NET4.0E)"
#define COOKIEMONSTER   "cookie.txt"

@implementation TBDPost
@synthesize username;
@synthesize password;
@synthesize postKey;
@synthesize host;
@synthesize path;
@synthesize status;
@synthesize postFields;
@synthesize shoutMsg;

static BOOL isStringExists(NSString* string, NSString* searchFor)
{
        NSRange searchRange;        
        searchRange.location = 0;
        searchRange.length = [string length];
        
        NSRange foundRange = [string rangeOfString:searchFor options:0  range:searchRange];
        if(foundRange.length > 0)
            return TRUE;
        return FALSE;
}
static NSString* strScan(NSString* string,NSString*startSearch,NSString*endSearch)
{
    NSArray* array  = [string componentsSeparatedByString:startSearch];
    NSArray* muaray =  [[array lastObject] componentsSeparatedByString:endSearch];
    return [muaray objectAtIndex:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
    cookie = [fields valueForKey:@"Set-Cookie"];
    NSLog(@"%@",cookie);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Show error
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Once this method is invoked, "responseData" contains the complete result
}

-(void)getData
{
//    self->stringData = [NSString stringWithContentsOfURL:[ NSURL URLWithString:self->url] encoding:NSUTF8StringEncoding error:nil];
    if (!responseData)
        responseData = [NSMutableData data];
    
    if (!request)
        request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self->url]];
    else
        [request setURL:[NSURL URLWithString:self->url]];
    [request setHTTPShouldHandleCookies:YES];
//        [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSString* string = [[NSString alloc]initWithData:self->responseData encoding:NSUTF8StringEncoding];
    self->stringData = string;
//    NSLog(@"%@",self->stringData);

}
-(void)postData
{
    NSLog(@"%@",self.postFields);
    if (!request)
        request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self->url]];
    else
        [request setURL:[NSURL URLWithString:self->url]];
    [ request setHTTPMethod: @"POST" ];
    [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [ request setHTTPBody: [self->postFields dataUsingEncoding:NSUTF8StringEncoding] ];
    NSURLResponse *response;
    NSError *err;
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    self->stringData = [NSString stringWithUTF8String:[returnData bytes]];
//    NSLog(@"%@",self->stringData);
}
-(void)Logout
{
    
}
-(void)GetKey
{
    self->postKey = [[strScan(self->stringData,@"var my_post_key =",@"\";") stringByReplacingOccurrencesOfString:@"\"" withString:@""]  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
}
-(void)Login
{
    self->url = [NSString stringWithFormat:@"%@%@/member.php",self->host,self->path];
    self->postFields = [NSString stringWithFormat:@"username=%@&password=%@&remember=yes&submit=Login&action=do_login&url=%@%@", self.username, self.password,self.host,self.path];
    [request addValue:cookie forHTTPHeaderField:@"Cookie"];
    [self postData];
    (!isStringExists(self->stringData,@"You have entered an invalid username") && self->stringData)?[self setStatus:@"success"]:[self setStatus:@"fail"];
    [self GetKey];
    NSLog(@"KEY:%@",self->postKey);

}
-(void)shout
{
    [self SendShout:shoutMsg];
}
-(void)SendShout:(NSString*) text
{
    self->url = [NSString stringWithFormat:@"%@%@/xmlhttp.php?action=add_shout",self.host,self.path];

    self->postFields = [NSString stringWithFormat:@"shout_data=%@&shout_key=%@", text, self.postKey];
    [self postData];
}

-(id)init
{
    self = [super init];
    if (self){
        self.postKey =@"";
    }
    return self;
}
//-(void)dealloc
//{
//    [self release];
//}
@end
