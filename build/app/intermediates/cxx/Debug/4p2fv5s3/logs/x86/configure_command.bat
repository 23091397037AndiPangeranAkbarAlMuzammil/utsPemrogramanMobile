@echo off
"C:\\Users\\User\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\flutter\\src\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=C:\\Users\\User\\AppData\\Local\\Android\\sdk\\ndk\\26.3.11579264" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\User\\AppData\\Local\\Android\\sdk\\ndk\\26.3.11579264" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\User\\AppData\\Local\\Android\\sdk\\ndk\\26.3.11579264\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\User\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\andi nitip\\SEMS 4\\MOBILE\\k3kuis\\build\\app\\intermediates\\cxx\\Debug\\4p2fv5s3\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\andi nitip\\SEMS 4\\MOBILE\\k3kuis\\build\\app\\intermediates\\cxx\\Debug\\4p2fv5s3\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BD:\\andi nitip\\SEMS 4\\MOBILE\\k3kuis\\android\\app\\.cxx\\Debug\\4p2fv5s3\\x86" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
