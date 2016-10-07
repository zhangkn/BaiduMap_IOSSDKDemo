//
//  AppDelegate.m
//  BaiduMap_IOSSDKDemo
//
//  Created by devzkn on 07/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"FkQype3nIGnRf9nxpZP5bzeF3gxlVhrI"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"manager start success!");
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/** Asks the delegate to open a resource identified by URL
 当被其他应用程序通过URL打开时就会调用  NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED;
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    NSString *str = url.absoluteString;//绝对路径
    if ([str hasPrefix:@"DK://login"]) {
        //跳转到授权界面／消息传递：openAppScheme 以便回到打开的app---url参数
        //截取参数，获得打开此app的程序等URLScheme信息
        NSRange range = [str rangeOfString:@"DK://login?openAppScheme="];
        NSString *openAppScheme = [str substringFromIndex:range.length];
        //方式一：发送通知，进行控制器切换；userinfo 可以用于传递消息
//        方式二：通过window，获取rootVC-》进行调整也可(void)performSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender //sender 可以用于传递消息
//        - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//        NavigetionController *nv = (NavigetionController*)self.selectedViewController;
        // 注意： UIViewController *topVc = nv.topViewController
#warning /*      //nv.topViewController 是自己的话，就只进行消息传递不跳转         if ([[[UIApplication sharedApplication].delegate window].rootViewController isKindOfClass:[LoginViewController class]]) {*/
        
    }else if([str hasPrefix:@"DK://detailView?id="]){
        
        //跳转到详情界面
        
    }
    return YES;//成功处理
}
#if 0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED{
    return YES;//成功处理
}
#endif

///** 
// Asks the delegate to open a resource specified by a URL, and provides a dictionary of launch options.
// 
// */
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    
//    
//    /*
//     UIApplicationOpenURLOptionsKey
//     Constants
//     UIApplicationOpenURLOptionsSourceApplicationKey
//     Contains the bundle ID of the app that sent the open-URL request to your app. Value is an NSString object.
//     UIApplicationOpenURLOptionsAnnotationKey
//     Contains the information passed to a UIDocumentInteractionController object’s annotation property. Value is a property list-typed object.
//     UIApplicationOpenURLOptionsOpenInPlaceKey
//     Contains a flag indicating whether a document must be copied before you use it. Value is Boolean, where YES indicates that you must copy the document to allow you to maintain access to it. If the flag is not set, you also must copy the document before you can use it.
//     */
//    
//    return YES;
//}
@end
