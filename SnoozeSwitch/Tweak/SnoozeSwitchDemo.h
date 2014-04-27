#include <UIKit/UIKit.h>
#include <QuartzCore/QuartzCore.h>
#define SNOOZE_INTERVAL 1.0
#define SNOOZE_COLOR [UIColor colorWithWhite:0.88 alpha:1.0]

@interface AlarmView : UIView {
	UISwitch *_enabledSwitch;
}

@property(nonatomic, retain) UISwitch *enabledSwitch;
- (id)enabledSwitch;
@end