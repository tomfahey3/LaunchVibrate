#import <AudioToolbox/AudioToolbox.h>

%hook SBApplicationIcon

- (void)launch {
	[self vibrateLaunch];
	%orig;
}
- (void)launchFromViewSwitcher {
	[self vibrateLaunch];
	%orig;
}

%new(v@:)
- (void)vibrateLaunch {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
%end

%hook SBBookmarkIcon

- (void)launch {
	[self vibrateBookmark];
	%orig;
}

%new(v@:)
- (void)vibrateBookmark {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

%end
