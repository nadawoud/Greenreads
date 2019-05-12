//
//  AppDelegate.h
//  Greenreads
//
//  Created by Nada Yehia Dawoud on 5/11/19.
//  Copyright © 2019 Mobile Apps Kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void(^)(NSData *data))completionHandler;


@end

