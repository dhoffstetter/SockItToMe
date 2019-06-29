//
//  AppDelegate.h
//  SockItToMe
//
//  Created by Diane Hoffstetter on 6/28/19.
//  Copyright © 2019 Dumb Blonde Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

