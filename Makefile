build:
	xcodebuild -project EyeTwenty.xcodeproj -scheme EyeTwenty build

run:
	open $$(xcodebuild -project EyeTwenty.xcodeproj -scheme EyeTwenty -showBuildSettings | grep -m 1 "TARGET_BUILD_DIR" | grep -oE "\/.*")/EyeTwenty.app
