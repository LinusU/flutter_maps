package com.linusu.flutter_maps

import java.util.concurrent.atomic.AtomicInteger

import android.content.Context

import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

import com.linusu.flutter_maps.FlutterMapController;

class FlutterMapFactory(private val activityState: AtomicInteger, private val pluginRegistrar: Registrar): PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, id: Int, args: Any?): PlatformView {
    return FlutterMapController(id, context, activityState, pluginRegistrar)
  }
}
