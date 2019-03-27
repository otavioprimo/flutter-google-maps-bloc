# Flutter Maps With Bloc Pattern

A Flutter application with tabs, google maps and bloc pattern

## API KEY

  Get an API key at https://cloud.google.com/maps-platform/.

  ### Android

  Specify your API key in the application manifest ```android/app/src/main/AndroidManifest.xml```: 
  ```
  <manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>
  ```
  ### IOS

  Specify your API key in the application delegate ```ios/Runner/AppDelegate.m```:
  ```
  #include "AppDelegate.h"
  #include "GeneratedPluginRegistrant.h"
  #import "GoogleMaps/GoogleMaps.h"

  @implementation AppDelegate

  - (BOOL)application:(UIApplication *)application
      didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"YOUR KEY HERE"];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
  }
  @end
  ```