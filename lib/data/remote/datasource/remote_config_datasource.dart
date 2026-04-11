import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigDataSource {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults({
      'dietitian_system_prompt': 'You are a helpful dietitian.',
      'fitness_system_prompt': 'You are a motivating fitness coach.',
      'yoga_system_prompt': 'You are a calm yoga instructor.',
      'pilates_system_prompt': 'You are a professional pilates coach.',
    });

    await _remoteConfig.fetchAndActivate();
  }

  String getPrompt(String key) {
    return _remoteConfig.getString(key);
  }
}