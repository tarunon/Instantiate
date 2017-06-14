# check platform
if [ $PLATFORM_NAME = "iphonesimulator" ]; then
    platform=`echo iOS`
    device=`echo iphone`
elif [ $PLATFORM_NAME = "macosx" ]; then
    platform=`echo macOS`
    device=`echo mac`
elif [ $PLATFORM_NAME = "appletvsimulator" ]; then
    platform=`echo tvOS`
    device=`echo tv`
else
    exit 1
fi
# compile xib
for filename in `find $PROJECT_DIR/Tests/$PRODUCT_MODULE_NAME/$platform -name "*.xib"`; do
    name=`basename $filename .xib`
    ibtool --errors --warnings --notices --module $PRODUCT_MODULE_NAME --output-partial-info-plist $TARGET_TEMP_DIR/$name-PartialInfo.plist --auto-activate-custom-fonts --target-device $device --minimum-deployment-target $DEPLOYMENT_TARGET_CLANG_ENV_NAME --output-format human-readable-text --compile $CONFIGURATION_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH/$name.nib $PROJECT_DIR/Tests/$PRODUCT_MODULE_NAME/$platform/$name.xib
done
# compile, link storyboard
for filename in `find $PROJECT_DIR/Tests/$PRODUCT_MODULE_NAME/$platform -name "*.storyboard"`; do
    name=`basename $filename .storyboard`
    ibtool --errors --warnings --notices --module $PRODUCT_MODULE_NAME --output-partial-info-plist $TARGET_TEMP_DIR/$name-SBPartialInfo.plist --auto-activate-custom-fonts --target-device $device --minimum-deployment-target $DEPLOYMENT_TARGET_CLANG_ENV_NAME --output-format human-readable-text --compilation-directory $TEMP_FILE_DIR $PROJECT_DIR/Tests/$PRODUCT_MODULE_NAME/$platform/ViewController.storyboard
    ibtool --errors --warnings --notices --module $PRODUCT_MODULE_NAME --target-device $device --minimum-deployment-target $DEPLOYMENT_TARGET_CLANG_ENV_NAME --output-format human-readable-text --link $CONFIGURATION_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH $TEMP_FILE_DIR/ViewController.storyboardc
done
