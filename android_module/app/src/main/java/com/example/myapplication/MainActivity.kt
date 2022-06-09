package com.method_channel.android_module

import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class MainActivity : AppCompatActivity() {
    private val CHANNEL = "samples.flutter.dev/args"
    private val ENGINE_ID = "flutter_engine"
    private var openedWithArgs = false
    private var backedWithArgs: Boolean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        attachButtons()
        attachFlutterEngine()
    }

    private fun attachFlutterEngine() {
        val flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getArgsValue" -> {
                    result.success(openedWithArgs);
                }
                "setArgsValue" -> {
                    result.success(true)
                    backedWithArgs = call.argument<Boolean>("args") as Boolean;
                    setTextView()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun attachButtons() {
        val woArgs = findViewById<Button>(R.id.bWOArgs)
        woArgs.setOnClickListener {
            onClick(false)
        }

        val wArgs = findViewById<Button>(R.id.bWArgs)
        wArgs.setOnClickListener {
            onClick(true)
        }
    }

    private fun onClick(withArgs: Boolean) {
        openedWithArgs = withArgs
        startActivity(
            FlutterActivity.withCachedEngine(ENGINE_ID).build(this)
        )
    }

    private fun setTextView() {
        val tv = findViewById<View>(R.id.tvArgs) as TextView

        if (backedWithArgs != null) {
            tv.text = "Backed With Arguments: " + backedWithArgs.toString()
        } else {
            tv.text = "Backed With Arguments: NULL VALUE"
        }

        tv.visibility = View.VISIBLE
    }
}