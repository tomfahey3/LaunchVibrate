#import <AudioToolbox/AudioToolbox.h>

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.app1enerd.launchvibrate.plist";

static BOOL icon;
static BOOL bookmark;
static BOOL anywhere;
static BOOL folder;
static BOOL unlock;

%hook SBApplicationIcon

- (void)launch {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		icon = [[settings objectForKey:@"icon"] boolValue];
	}
	if (icon) {
		[self vibrateLaunch];
	}
	%orig;
}
- (void)launchFromViewSwitcher {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		icon = [[settings objectForKey:@"icon"] boolValue];
	}
	if (icon) {
		[self vibrateLaunch];
	}
	%orig;
}

%new(v@:)
- (void)vibrateLaunch {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
%end

%hook SBBookmarkIcon

- (void)launch {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		bookmark = [[settings objectForKey:@"bookmark"] boolValue];
	}
	if (bookmark) {
		[self vibrateBookmark];
	}
	%orig;
}

%new(v@:)
- (void)vibrateBookmark {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

%end

%hook SBApplication

- (void)activate {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		anywhere = [[settings objectForKey:@"anywhere"] boolValue];
	}
	if (anywhere) {
		[self vibrateAnywhere];
	}
	%orig;
}

%new(v@:)
- (void)vibrateAnywhere {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
%end

%hook SBFolderIcon

- (void)launch {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		folder = [[settings objectForKey:@"folder"] boolValue];
	}
	if (folder) {
		[self vibrateFolder];
	}
	%orig;
}

%new(v@:)
- (void)vibrateFolder {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

%end

%hook TPBottomLockBar

- (void)unlock {
	if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
		NSDictionary *settings = [[NSDictionary dictionaryWithContentsOfFile:settingsFile] retain];
		unlock = [[settings objectForKey:@"unlock"] boolValue];
	}
	if (unlock) {
		[self vibrateAtUnlock];
	}
	%orig;
}

%new(v@:)
- (void)vibrateAtUnlock {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
%end