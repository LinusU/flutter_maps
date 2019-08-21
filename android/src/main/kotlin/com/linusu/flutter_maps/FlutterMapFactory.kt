package com.linusu.flutter_maps

import java.util.concurrent.atomic.AtomicInteger

import android.content.Context
import com.google.android.gms.maps.GoogleMapOptions

import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

import com.linusu.flutter_maps.FlutterMapController;
import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.LatLng
import java.util.*


class FlutterMapFactory(private val activityState: AtomicInteger, private val pluginRegistrar: Registrar): PlatformViewFactory(StandardMessageCodec.INSTANCE) {

  override fun create(context: Context, id: Int, args: Any?): PlatformView {
    val options = GoogleMapOptions()
    val params = args as Map<String, Any>

    if (params.containsKey("initialCameraPosition")) {
      val position: Map<String, Any> = params["initialCameraPosition"] as Map<String, Any>
      options.camera(CameraPosition(LatLng(position["lat"] as Double, position["lng"] as Double), (position["zoomLevel"] as Double).toFloat(), 0.0f, 0.0f))
    }

    return FlutterMapController(id, context, activityState, pluginRegistrar, options)
  }
}

