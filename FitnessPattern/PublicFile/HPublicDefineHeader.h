//
//  HPublicDefineHeader.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/11.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#ifndef FitnessPattern_HPublicDefineHeader_h
#define FitnessPattern_HPublicDefineHeader_h

#define FontColor_ContentTextView [UIColor colorWithRed:73.0f/255.0f green:71.0f/255.0f blue:80.0f/255.0f alpha:1]

//主题桔红
#define Color_ThemeOrange [UIColor colorWithRed:241.0f/255.0f green:113.0f/255.0f blue:10.0f/255.0f alpha:1.0f]

//主题灰
#define Color_TemeGray [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1.0f]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]


//背景色
#define Color_AppBackground [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define NSUSERDEFAULTSINIT [NSUserDefaults standardUserDefaults]
#define STORYBOARD [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
#define GETMYTOKEN     [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]]



#endif
