package com.example.media_demo

import android.graphics.Bitmap
import android.media.ThumbnailUtils
import android.provider.MediaStore
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "video_thumbnail"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getThumbnail") {
                val videoPath = call.argument<String>("videoPath")
                if (videoPath != null) {
                    val thumbnailPath = getVideoThumbnail(videoPath)
                    if (thumbnailPath != null) {
                        result.success(thumbnailPath)
                    } else {
                        result.error("THUMBNAIL_ERROR", "Failed to generate thumbnail", null)
                    }
                } else {
                    result.error("INVALID_PATH", "Video path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getVideoThumbnail(videoPath: String): String? {
        return try {
            val bitmap = ThumbnailUtils.createVideoThumbnail(
                videoPath,
                MediaStore.Images.Thumbnails.MINI_KIND
            )
            if (bitmap != null) {
                val file = File.createTempFile("thumb", ".jpg", cacheDir)
                bitmap.compress(Bitmap.CompressFormat.JPEG, 85, FileOutputStream(file))
                file.absolutePath
            } else {
                null
            }
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}
