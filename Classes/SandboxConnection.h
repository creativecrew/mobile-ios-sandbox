/**
@file
    SandboxConnection.h
@brief
    Copyright 2008 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2008-12-14
    - Modified: 2008-12-14
    .
@note
    References:
    - General:
        - http://code.google.com/p/json-framework/
        .
    .
*/

#define CONNECTION_TIMEOUT 120.0

@interface SandboxConnection : NSObject {
    id delegate;
	NSURLConnection* connection;
    NSHTTPURLResponse* response;
	NSMutableData* buffer;
    int statusCode;
    BOOL needAuth;
}

@property (nonatomic, readonly) NSMutableData* buffer;
@property (nonatomic, assign) int statusCode;

- (id) initWithDelegate:(id)idDelegate;
- (void) get:(NSString*)strURL;
- (void) post:(NSString*)strURL text:(NSString*)strText;
//- (void) post:(NSString*)strURL data:(NSData*)data;
//- (void) cancel;

//- (void) connectionDidFailWithError:(NSError*)error;
//- (void) connectionDidFinishLoading:(NSString*)content;

@end
