#  flutter_module_method_channel
A new flutter module project.

##  Getting Started
For help getting started with Flutter, view our online [documentation](https://flutter.dev/).
For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

##  To Run
- flutter clean
- flutter pub get

	### Android
	- generate **key.jks** and place in root **android_module** (change the config **key.properties**)
	- flutter build aar
	- Replace **{{arrPath}}** in **settings.gradle** and **app/build.gradle** with the output path
	- Run

	### iOS
	- flutter build ios (requires signing) 
	- Run in Xcode
