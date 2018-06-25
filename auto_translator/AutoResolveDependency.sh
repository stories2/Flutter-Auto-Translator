#!/bin/bash

echo "Remove Podfile.lock"
rm ios/Podfile.lock

echo "Remove Pods"
rm -rf Pods

echo "Install pods"
cd ios
pod install

echo "Clean flutter"
cd ..
flutter clean

echo "Run all devices"
flutter run -d all
