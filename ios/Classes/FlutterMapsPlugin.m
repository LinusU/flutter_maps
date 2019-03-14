#import "FlutterMapsPlugin.h"
#import <flutter_maps/flutter_maps-Swift.h>

@implementation FlutterMapsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMapsPlugin registerWithRegistrar:registrar];
}
@end
