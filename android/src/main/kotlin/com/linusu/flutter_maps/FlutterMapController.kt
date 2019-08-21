package com.linusu.flutter_maps

import java.util.concurrent.atomic.AtomicInteger

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.view.View
import com.google.android.gms.maps.*

import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformView

import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.LatLng
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterMapController(
        private val id: Int,
        private val context: Context,
        private val activityState: AtomicInteger,
        private val registrar: Registrar,
        private val options: GoogleMapOptions) : Application.ActivityLifecycleCallbacks,
        OnMapReadyCallback, PlatformView, MethodChannel.MethodCallHandler {

  private val mapView = MapView(context, options)
  private val registrarActivityHashCode = registrar.activity().hashCode()

  private var disposed = false
  private var googleMap: GoogleMap? = null

  private var methodChannel: MethodChannel? = null

  init {
    methodChannel = MethodChannel(registrar.messenger(), "com.linusu/flutter_maps")
    methodChannel?.setMethodCallHandler(this)

    when (activityState.get()) {
      STOPPED -> {
        mapView.onCreate(null)
        mapView.onStart()
        mapView.onResume()
        mapView.onPause()
        mapView.onStop()
      }
      PAUSED -> {
        mapView.onCreate(null)
        mapView.onStart()
        mapView.onResume()
        mapView.onPause()
      }
      RESUMED -> {
        mapView.onCreate(null)
        mapView.onStart()
        mapView.onResume()
      }
      STARTED -> {
        mapView.onCreate(null)
        mapView.onStart()
      }
      CREATED -> {
        mapView.onCreate(null)
      }
      DESTROYED -> {
        // Nothing to do, the activity has been completely destroyed.
      }
      else -> {
        throw IllegalArgumentException("Cannot interpret " + activityState.get() + " as an activity state")
      }
    }
    registrar.activity().getApplication().registerActivityLifecycleCallbacks(this)
    mapView.getMapAsync(this)
  }

  override fun getView(): View {
    return mapView
  }

  override fun onMapReady(googleMap: GoogleMap) {
    this.googleMap = googleMap
  }

  override fun onMethodCall(p0: MethodCall, p1: MethodChannel.Result) {
    when(p0.method) {
      "zoomTo" -> zoomTo(p0, p1)
    }
  }

  private fun zoomTo(methodCall: MethodCall, methodChannelResult: MethodChannel.Result) {
    val latitude: Double? = methodCall.argument("lat")
    val longitude: Double? = methodCall.argument("lng")
    val zoomLevel: Double? = methodCall.argument("zoomLevel")
    val camera = CameraPosition.builder()
            .target(LatLng(latitude!!, longitude!!))
            .zoom(zoomLevel!!.toFloat())
            .build()

    googleMap?.animateCamera(CameraUpdateFactory.newCameraPosition(camera))
  }

  override fun dispose() {
    if (disposed) return;
    disposed = true
    mapView.onDestroy()
    registrar.activity().getApplication().unregisterActivityLifecycleCallbacks(this)
  }

  override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onCreate(savedInstanceState)
  }

  override fun onActivityStarted(activity: Activity) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onStart()
  }

  override fun onActivityResumed(activity: Activity) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onResume()
  }

  override fun onActivityPaused(activity: Activity) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onPause()
  }

  override fun onActivityStopped(activity: Activity) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onStop()
  }

  override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onSaveInstanceState(outState)
  }

  override fun onActivityDestroyed(activity: Activity) {
    if (!disposed && activity.hashCode() == registrarActivityHashCode) mapView.onDestroy()
  }
}

