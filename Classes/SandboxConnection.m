#import "SandboxConnection.h"

@implementation SandboxConnection

@synthesize buffer;
@synthesize statusCode;

//---------------------------------------------------------------------
- (id) initWithDelegate:(id)idDelegate {
	self = [super init];
	delegate = idDelegate;
    statusCode = 0;
    needAuth = false;
	return self;
}
//---------------------------------------------------------------------
- (void) addAuthHeader:(NSMutableURLRequest*)req {
    if(!needAuth) return;
    
    NSString* username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
	NSString* password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    NSString* auth = [NSString stringWithFormat:@"%@:%@", username, password];
    //NSString* basicauth = [NSString stringWithFormat:@"Basic %@", [NSString base64encode:auth]];
    //[req setValue:basicauth forHTTPHeaderField:@"Authorization"];
}
//---------------------------------------------------------------------
- (void) get:(NSString*)strURL {
    [connection release];
	[buffer release];
    statusCode = 0;
    
    NSString* URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)strURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
    NSLog(@"%@", URL);
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:CONNECTION_TIMEOUT];
    
    [self addAuthHeader:req];
    
  	buffer = [[NSMutableData data] retain];
	connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
//---------------------------------------------------------------------
-(void) post:(NSString*)strURL text:(NSString*)strText {
    [connection release];
    [buffer release];
    statusCode = 0;

    NSString* URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)strURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:CONNECTION_TIMEOUT];

    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [self addAuthHeader:req];

    int contentLength = [strText lengthOfBytesUsingEncoding:NSUTF8StringEncoding];

    [req setValue:[NSString stringWithFormat:@"%d", contentLength] forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[NSData dataWithBytes:[strText UTF8String] length:contentLength]];

    buffer = [[NSMutableData data] retain];
    connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
//---------------------------------------------------------------------
- (void) dealloc {
    [connection release];
    [buffer release];
	[super dealloc];
}
//---------------------------------------------------------------------
@end
