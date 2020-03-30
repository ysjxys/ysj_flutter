#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterScanPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    [FlutterScanPlugin registerWithRegistrar: [self registrarForPlugin:@"FlutterScanPlugin"]];
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
