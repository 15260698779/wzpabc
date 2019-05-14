//
//  ViewController.m
//  Test
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import <TZImagePickerController.h>
@interface ViewController ()<TZImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tad:(id)sender {
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // 是否显示可选原图按钮
    imagePicker.allowPickingOriginalPhoto = YES;
    // 是否允许显示视频
    // 是否允许显示视频
    imagePicker.allowPickingVideo = NO;
//    imagePicker.cropRect = CGRectMake(0, 0, 200, 100);
    imagePicker.allowCrop = YES;
    // 是否允许显示图片
    imagePicker.allowPickingImage = YES;
    imagePicker.allowTakePicture = NO;
    //  imagePicker.cropRect = CGRectMake(0, 0, 200, 60);
    // 这是一个navigation 只能present
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (IBAction)video:(id)sender {
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // 是否显示可选原图按钮
    imagePicker.allowPickingOriginalPhoto = YES;
    // 是否允许显示视频
    // 是否允许显示视频
    imagePicker.allowPickingVideo = YES;
    imagePicker.videoMaximumDuration = 10;
    // 是否允许显示图片
    imagePicker.allowPickingImage = NO;
    //  imagePicker.cropRect = CGRectMake(0, 0, 200, 60);
    // 这是一个navigation 只能present
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark TZImagePickerControllerDelegate
// 选择照片的回调
-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    for (UIImage *image in photos) {
//        NSLog(@"images----%f",images);
        NSData *imageData = UIImagePNGRepresentation(image);
    }
    
    
    
}
-(void)mov2mp4:(NSURL *)videoUrl{
     AVURLAsset*avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoUrl.absoluteString]options:nil];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
      NSArray*compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        NSURL*newVideoUrl ;
        //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4",
          [formater stringFromDate:[NSDate date]]]];
        exportSession.outputURL= newVideoUrl;
        //要转换的格式，这里使用 MP4
        exportSession.outputFileType=AVFileTypeMPEG4;  //转换的数据是否对网络使用优化
        exportSession.shouldOptimizeForNetworkUse=YES;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
            switch(exportSession.status) {
                case AVAssetExportSessionStatusUnknown:{
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                }
                    break;
                case AVAssetExportSessionStatusWaiting:{
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                }
                    break;
                case AVAssetExportSessionStatusExporting:{
                    NSLog(@"AVAssetExportSessionStatusExporting");
                }
                    break;
                case AVAssetExportSessionStatusFailed:{
                    NSLog(@"AVAssetExportSessionStatusFailed");
                }
                    break;
                case AVAssetExportSessionStatusCancelled:{
                    NSLog(@"AVAssetExportSessionStatusCancelled");
                }
                    break;
                case AVAssetExportSessionStatusCompleted:{
                    //转换完成
                      NSLog(@"AVAssetExportSessionStatusCompleted");
//                     UISaveVideoAtPathToSavedPhotosAlbum([exportSession.outputURL path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
                  
               }
                    break;
            }
            
        }];
          
        
        
    }
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}
// 选择视频的回调
-(void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingVideo:(UIImage *)coverImage
                sourceAssets:(PHAsset *)asset{
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        NSString * url = [[[info objectForKey:@"PHImageFileSandboxExtensionTokenKey"]componentsSeparatedByString:@";"] lastObject];
        NSURL *urls = [NSURL fileURLWithPath:url];
        [self mov2mp4:urls];
        //第二步:创建视频播放器
        //第二步:创建视频播放器
     
        
        //        NSString *path  = [[NSBundle mainBundle]  pathForResource:@"1" ofType:@"mp4"];
        //        NSURL *url = [NSURL fileURLWithPath:path];
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            //      AVPlayer *avPlayer= [AVPlayer playerWithURL:urls];
            //      // player的控制器对象
            //      AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
            //      playerViewController.videoGravity = AVLayerVideoGravityResizeAspect; // 是否显示播放控制条
            //      // 控制器的player播放器
            //      playerViewController.player = avPlayer;
            //      [self presentViewController:playerViewController animated:YES completion:^{
            //
            //      }];
        });
        
    }];
    
    
}
@end
