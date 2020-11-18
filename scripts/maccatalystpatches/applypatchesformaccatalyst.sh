echo "Applying patch for AppDelegate.m"
patch ios/BlueWallet/AppDelegate.m  ./scripts/maccatalystpatches/appdelegate.patch
echo "Applying patch for package.json"
patch package.json ./scripts/maccatalystpatches/packagejson.patch
echo "Removing node_modules"
rm -fr node_modules
echo "Removing ios/Pods"
rm -fr ios/Pods
echo "Removing ios/Podfile.lock"
rm -fr ios/Podfile.lock
echo "Re-installing node_modules"
npm i
echo "Applying patch for react-native-camera"
cd node_modules/react-native-camera/ios/RCT
patch RCTCameraManager.m ../../../../scripts/maccatalystpatches/RCTCameraManager.patch
cd ../RN/
patch RNCamera.m ../../../../scripts/maccatalystpatches/RNCamera.patch
echo "Applying patch for react-native-image-picker"
cd ../../../../
cd node_modules/react-native-image-picker/ios
patch ImagePickerManager.m ../../../scripts/maccatalystpatches/ImagePickerManager.patch 
echo "Applying patch for Podfile"
cd ../../../
patch ios/Podfile ./scripts/maccatalystpatches/podfile.patch
echo "Applying patch for realm podspec"
patch node_modules/realm/RealmJS.podspec ./scripts/maccatalystpatches/realm.patch
cd ios
pod update
echo ""
echo "You should now be able to compile BlueWallet using Mac Catalyst on XCode. Enable Mac under Deployment Info by using XCode. If you are running macOS Catalina, you will need to remove the iOS 14 Widgets from the project targets."