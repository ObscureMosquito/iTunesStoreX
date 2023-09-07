#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>
#import <CustomURLProtocol.h>

%hook NSURL

- (instancetype)initWithString:(NSString *)URLString {

    // URLs to modify
    NSString *baseURLToModify1 = @"http://ax.init.itunes.apple.com";

    // Check if the URL starts with the specified base URLs
    if ([URLString hasPrefix:baseURLToModify1]) {

        NSURL *oldURL = [NSURL URLWithString:URLString];
        NSString *path = [oldURL path];
        NSString *query = [oldURL query];

        // Ax init replacement, also dv6->7
        NSString *newBaseURL = @"http://init.itunes.apple.com";
        NSString *newURLString = [NSString stringWithFormat:@"%@%@%@", newBaseURL, path, (query ? [NSString stringWithFormat:@"?%@", query] : @"")];

        // Create a new NSURL instance with the modified URL
        NSURL *newURL = [NSURL URLWithString:newURLString];

        return newURL;
    } else {
        // If the URL doesn't need modification, return the original NSURL instance
        return %orig;
    }
}

%end

%hook NSURLRequest

static void RegisterCustomURLProtocol() {
    [NSURLProtocol registerClass:[CustomURLProtocol class]];
}

__attribute__((constructor))
static void init_hook() {
    // Register your custom protocol class
    RegisterCustomURLProtocol();

    // Other initialization code for your tweak
}

%end