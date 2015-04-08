#import <UIKit/UIKit.h>

@interface PopupView : UIView
{
    UILabel         *_textLabel;
    int             _queueCount;
}
@property (strong) UIView*  ParentView;
- (void) setText:(NSString *) text;

@end
