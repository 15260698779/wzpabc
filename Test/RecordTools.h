//
//  RecordTools.h
//  Test
//
//  Created by 乌拉拉 on 2019/5/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RecordTools : NSObject
+ (void)convertMovToMp4FromAVURLAsset:(AVURLAsset*)urlAsset andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler;
@end

NS_ASSUME_NONNULL_END
