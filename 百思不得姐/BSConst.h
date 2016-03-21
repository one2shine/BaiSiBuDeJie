#import <UIKit/UIKit.h>

extern CGFloat const BSTopicCellBottomBarHeight;
extern CGFloat const BSTopicCellTextY;
extern CGFloat const BSTopicCellMargin;

extern CGFloat const BSTitlesViewY;
extern CGFloat const BSTitlesViewH;

typedef enum {
    BSDuanziTypeAll = 1,
    BSDuanziTypeVideo = 41,
    BSDuanziTypeVoice = 31,
    BSDuanziTypePhoto = 10,
    BSDuanziTypeTopic = 29
    
} BSDuanziType;

UIKIT_EXTERN NSString * const BSUserSexMale;
UIKIT_EXTERN NSString * const BSUserSexFemale;