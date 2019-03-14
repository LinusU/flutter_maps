package com.linusu.flutter_maps

import java.util.concurrent.atomic.AtomicInteger

import android.app.Activity
import android.app.Application
import android.os.Bundle

import io.flutter.plugin.common.PluginRegistry.Registrar

import com.linusu.flutter_maps.FlutterMapController;
import com.linusu.flutter_maps.FlutterMapFactory;

class FlutterMapsPlugin private constructor (private val registrar: Registrar): Application.ActivityLifecycleCallbacks {
  private val state = AtomicInteger(0)
  private val registrarActivityHashCode = registrar.activity().hashCode()

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      if (registrar.activity() == null) {
        // When a background flutter view tries to register the plugin, the registrar has no activity.
        // We stop the registration process as this plugin is foreground only.
        return
      }

      val plugin = FlutterMapsPlugin(registrar)
      registrar.activity().getApplication().registerActivityLifecycleCallbacks(plugin)
      registrar.platformViewRegistry().registerViewFactory("com.linusu/flutter_maps", FlutterMapFactory(plugin.state, registrar))
    }
  }

  override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(CREATED)
  }

  override fun onActivityStarted(activity: Activity) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(STARTED)
  }

  override fun onActivityResumed(activity: Activity) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(RESUMED)
  }

  override fun onActivityPaused(activity: Activity) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(PAUSED)
  }

  override fun onActivityStopped(activity: Activity) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(STOPPED)
  }

  override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {}

  override fun onActivityDestroyed(activity: Activity) {
    if (activity.hashCode() == registrarActivityHashCode) state.set(DESTROYED)
  }
}
