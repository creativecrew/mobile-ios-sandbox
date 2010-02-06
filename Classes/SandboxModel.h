/**
@file
    SandboxModel.h
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

#import <Foundation/Foundation.h>


@interface SandboxModel : NSObject {

}

- (NSString*) getMessage;
- (void) setMessage:(NSString*)strText;

@end
