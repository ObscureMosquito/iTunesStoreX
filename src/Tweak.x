#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <substrate.h>
#import <CustomURLProtocol.h>


%hook ISLoadURLBagOperation

- (void)operation:(id)operation willSendRequest:(NSMutableURLRequest *)request {
    NSURL *currentURL = [request URL];
    NSString *urlString = [currentURL absoluteString];
    NSRange range = [urlString rangeOfString:@"ax.init.itunes.apple.com"];
    if (range.location != NSNotFound) {
        NSString *newURLString = [urlString stringByReplacingOccurrencesOfString:@"ax.init.itunes.apple.com" withString:@"init.itunes.apple.com"];
        
        NSURL *newURL = [NSURL URLWithString:newURLString];
        [request setURL:newURL];
    }
    %orig;
}

%end


%hook NSURLRequest

static void RegisterCustomURLProtocol() {
    [NSURLProtocol registerClass:[CustomURLProtocol class]];
}

__attribute__((constructor))
static void init_hook() {
    RegisterCustomURLProtocol();
}

%end
