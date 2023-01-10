#import "yy.h"
#include <string>
#import <AVFoundation/AVFoundation.h>
#define kuandu  [UIScreen mainScreen].bounds.size.width
#define gaodu [UIScreen mainScreen].bounds.size.height
#pragma mark 读取数据
template<typename T> T defrgfas(long address) {
    T data;
    RRDVGF(address, sizeof(T),reinterpret_cast<void *>(&data));
    return data;
}

static NSTimer*GWDGRFGSGF;
static NSTimer*HZDSQGESREFWFG;
static NSTimer*fergfhg;
static long baseAdd;

static NSString*敌人数据;
static NSString*物资数据;
static NSString*未知数据;
static float 初始当前音量;
static float 最新音量;
static BOOL 物资开关;
static 最小视图信息 POV;
static NSString*UDID;

static AVAudioSession *audioSession;

@implementation fsgf : NSObject

+(void)load
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[fsgf alloc] DFGFSVBF];
        });
        
    });
    
}
//定时器
-(void)DFGFSVBF
{
    //读取GW定时器
    fergfhg = [NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
        baseAdd=get_base_address(@"ShadowTracker");
        if (baseAdd) {
            //判断定时器是否为空
            if (HZDSQGESREFWFG==nil) {
                [self WEFRGHGFS5HRTEGREFA];
            }
            if (GWDGRFGSGF==nil) {
                [self HGFEDFRGT];
            }
            NSString*pzstr=[NSString stringWithFormat:@"%f,%f,%@,%@",kuandu,gaodu,UDID,vvv];
            [self 写数据:pzstr file:@".pz"];
        }else{
            
            //释放定时器
            [HZDSQGESREFWFG invalidate];
            HZDSQGESREFWFG=nil;
            [GWDGRFGSGF invalidate];
            GWDGRFGSGF=nil;
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:fergfhg forMode:NSRunLoopCommonModes];
    
}
//HGFEDFRGT
-(void)HGFEDFRGT
{
    GWDGRFGSGF = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        最新音量 = [audioSession outputVolume];
        if (初始当前音量!=最新音量) {
            物资开关=!物资开关;
            UDID=IPFAGNEGFQDFBSG();
            初始当前音量 = 最新音量;
            
        }
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:GWDGRFGSGF forMode:NSRunLoopCommonModes];
}
//绘制定时器
-(void)WEFRGHGFS5HRTEGREFA
{
    HZDSQGESREFWFG = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self HGFPGJGFAGHB];
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:HZDSQGESREFWFG forMode:NSRunLoopCommonModes];
}
//读取数据
-(void)HGFPGJGFAGHB
{
    
    long GWorld = defrgfas<long>(baseAdd+0xA6EF9D0);
    auto ULevel = defrgfas<long>(GWorld + 0x90);
    long ActorArray = defrgfas<long>(ULevel + 0xA0);
    long ActorCount = defrgfas<int>(ULevel + 0xA8);
    long UName = defrgfas<long>(baseAdd + 0xA4D22D8);
    int 队友排序=1;
    NSMutableArray *敌人数组 = @[].mutableCopy;
    NSMutableArray * 物资数组= @[].mutableCopy;
    NSMutableArray * 未知数组= @[].mutableCopy;
    float zjx,zjy,zjz;
    for (int i = 0; i < ActorCount; i++) {
        long base = defrgfas<long>(ActorArray + i*8);
        int objID = defrgfas<int>(base + 0x18);
        
        int IdDiv = (int)(objID / 16384);
        int Idtemp = (int)(objID % 16384);
        long NamePtr = defrgfas<long>(UName + IdDiv * 0x8);
        long Nametemp = defrgfas<long>(NamePtr + Idtemp * 0x8) + 0xe;
        char Name [64];
        RRDVGF(Nametemp,64,Name);
        NSString *ClassName= [NSString stringWithFormat:@"%s",std::string(Name).c_str()];
        //计算距离
        auto rootComponent = defrgfas<long>(base + 0x258);
        VV3 objlnfo = defrgfas<VV3>(rootComponent + 0x1c0);
        if ([ClassName containsString:@"PlayerPawn"]){
            //排除死亡
            int bDead = defrgfas<int>(base+0xd68);
            if (bDead != 2) continue;
            float 血量 = defrgfas<float>(base + 0xD00);
            int 人机 = defrgfas<int>(base + 0xA14);
            int duibiao = defrgfas<int>(base+0xA08);
            if (duibiao == -1) continue;
            auto NetDriver = defrgfas<long>(GWorld + 0x98);
            auto ServerConnection = defrgfas<long>(NetDriver + 0x78);
            long localPlayerController = defrgfas<long>(ServerConnection + 0x30);
            long playerCameraManager = defrgfas<long>(localPlayerController + 0x5a8);
            long mySelf = defrgfas<long>(localPlayerController + 0x520);
            
            
            long 名称指针 = defrgfas<long>(base + 0x998);
            UTF8 玩家名字[32] = "";
            UTF16 buf16[16] = {0};
            RRDVGF(名称指针,28, buf16);
            Utf16_To_Utf8(buf16, 玩家名字, 28, strictConversion);
            NSString*MingZhi = [NSString stringWithUTF8String:(const char *)玩家名字];
            //读取自己
            static int MyTeam;
            if (mySelf == base) {
                MyTeam=duibiao;
                zjx=objlnfo.X;
                zjy=objlnfo.Y;
                zjz=objlnfo.Z;
            }
            
            if(duibiao==MyTeam){
                MingZhi=[NSString stringWithFormat:@"自己队友%d",队友排序++];
            }
            if (人机 == 1) {
                MingZhi=@"Ai_人机";
            }
            
            
            POV = defrgfas<最小视图信息>(playerCameraManager + 0x1130 + 0x10);
            //骨骼
            auto mesh = defrgfas<long>(base + 0x5a0);
            转换 meshTrans = defrgfas<转换>(mesh + 0x1b0);
            矩阵 c2wMatrix = TransformToMatrix(meshTrans,POV);
            auto boneArray = defrgfas<long>(mesh + 0x6e0);
            VV3 头 = shrgaeFW(boneArray + 288, c2wMatrix);
            float toux= worldsgewF(头).X;
            float touy= worldsgewF(头).Y;
            
            VV3 胸 = shrgaeFW(boneArray + 192 , c2wMatrix);
            float jizhux = worldsgewF(胸).X;
            float jizhuy = worldsgewF(胸).Y;
            
            VV3 盆骨 = shrgaeFW(boneArray + 48 , c2wMatrix);
            float pengux = worldsgewF(盆骨).X;
            float penguy = worldsgewF(盆骨).Y;
            
            VV3 左肩 = shrgaeFW(boneArray + 576 , c2wMatrix);
            float zuojianbangx = worldsgewF(左肩).X;
            float zuojianbangy = worldsgewF(左肩).Y;
            
            VV3 右肩 = shrgaeFW(boneArray + 1584 , c2wMatrix);
            float youjianbangx = worldsgewF(右肩).X;
            float youjianbangy = worldsgewF(右肩).Y;
            
            VV3 左肘 = shrgaeFW(boneArray + 624 , c2wMatrix);
            float zuozoux =  worldsgewF(左肘).X;
            float zuozouy =  worldsgewF(左肘).Y;
            
            VV3 右肘 = shrgaeFW(boneArray + 1632 , c2wMatrix);
            float youzoux =  worldsgewF(右肘).X;
            float youzouy =  worldsgewF(右肘).Y;
            
            VV3 左手 = shrgaeFW(boneArray + 672 , c2wMatrix);
            float zuosoux =  worldsgewF(左手).X;
            float zuosouy =  worldsgewF(左手).Y;
            
            VV3 右手 = shrgaeFW(boneArray + 1680 , c2wMatrix);
            float yousoux =  worldsgewF(右手).X;
            float yousouy =  worldsgewF(右手).Y;
            
            VV3 左大腿 = shrgaeFW(boneArray + 2544 , c2wMatrix);
            float zuopengux =  worldsgewF(左大腿).X;
            float zuopenguy =  worldsgewF(左大腿).Y;
            
            VV3 右大腿 = shrgaeFW(boneArray + 2736 , c2wMatrix);
            float youpengux =  worldsgewF(右大腿).X;
            float youpenguy =  worldsgewF(右大腿).Y;
            
            VV3 左膝 = shrgaeFW(boneArray + 2592 , c2wMatrix);
            float zuoxigaix =  worldsgewF(左膝).X;
            float zuoxigaiy =  worldsgewF(左膝).Y;
            
            VV3 右膝 = shrgaeFW(boneArray + 2784 , c2wMatrix);
            float youxigaix =  worldsgewF(右膝).X;
            float youxigaiy =  worldsgewF(右膝).Y;
            
            VV3 左脚 = shrgaeFW(boneArray + 2640 , c2wMatrix);
            float zuojiaox =  worldsgewF(左脚).X;
            float zuojiaoy =  worldsgewF(左脚).Y;
            
            VV3 右脚 = shrgaeFW(boneArray + 2832 , c2wMatrix);
            float youjiaox =  worldsgewF(右脚).X;
            float youjiaoy =  worldsgewF(右脚).Y;
            
            float drx=objlnfo.X;
            float dry=objlnfo.Y;
            float drz=objlnfo.Z;
            
            float distX = (drx - zjx) / 100;
            float distY = (dry - zjy) / 100;
            float distance = (distX * distX) + (distY * distY);
            float distZ = (drz - zjz) / 100;
            float juli = sqrt((distZ * distZ) + distance);
            
            NSString*单个敌人数据=[NSString stringWithFormat:@"%d,%@,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f",duibiao,MingZhi,血量,drx/100,dry/100,drz/100,juli,toux,touy,jizhux,jizhuy,pengux,penguy,zuosoux,zuosouy,zuozoux,zuozouy,zuojianbangx,zuojianbangy,youjianbangx,youjianbangy,youzoux,youzouy,yousoux,yousouy,zuojiaox,zuojiaoy,zuoxigaix,zuoxigaiy,zuopengux,zuopenguy,youpengux,youpenguy,youxigaix,youxigaiy,youjiaox,youjiaoy];
            
            [敌人数组 addObject:单个敌人数据];
            
        }else{
            if (物资开关) {
                float distX = (objlnfo.X - zjx) / 100;
                float distY = (objlnfo.Y - zjy) / 100;
                float distance = (distX * distX) + (distY * distY);
                float distZ = (objlnfo.Z - zjz) / 100;
                float juli = sqrt((distZ * distZ) + distance);
                if (juli<5) {
                    [未知数组 addObject:ClassName];
                }
                NSString *物资名字优化=[self 物资转换:ClassName];
                if(物资名字优化.length<2)continue;
                NSString *wuzhidata=[NSString stringWithFormat:@"%@,%.2f,%.2f,%.2f",物资名字优化,(objlnfo.X)/100,(objlnfo.Y)/100,(objlnfo.Z)/100];
                [物资数组 addObject:[NSString stringWithString:wuzhidata]];
            }
        }
        
    }
    物资数据=[物资数组 componentsJoinedByString:@"\n"];
    敌人数据=[敌人数组 componentsJoinedByString:@"\n"];
    未知数据=[未知数组 componentsJoinedByString:@"\n"];
    if (!物资开关){
        物资数据=@"关闭";
    }
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString*敌人=[NSString stringWithFormat:@".%@dr",UDID];
        [self 写数据:敌人数据 file:敌人];
    });
    //写入沙盒 用于其他功能
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString*物资=[NSString stringWithFormat:@".%@wz",UDID];
        [self 写数据:物资数据 file:物资];
    });
    //写入沙盒 用于其他功能
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString*物资=[NSString stringWithFormat:@".%@bz",UDID];
        [self 写数据:未知数据 file:物资];
    });
    
    
    
}

//物资名字优化
-(NSString*)物资转换:(NSString*)物资
{
    //载具
    if ([物资 containsString:@"Scooter"]) {
        return @"小绵羊";
    }
    if ([物资 containsString:@"Motorcycle_C"]) {
        return @"摩托车";
    }
    if ([物资 containsString:@"MotorcycleCart"]||[物资 containsString:@"BP_VH_Tuk_"]) {
        return @"三蹦子";
    }
    if ([物资 containsString:@"VH_Buggy"]) {
        return @"蹦蹦";
    }
    if ([物资 containsString:@"PickUp_0"]) {
        return @"皮卡";
    }
    if ([物资 containsString:@"Mirado_"]) {
        return @"跑车";
    }
    if ([物资 containsString:@"Dacia"]) {
        return @"轿车";
    }
    if ([物资 containsString:@"UAZ"]) {
        return @"吉普";
    }
    if ([物资 containsString:@"AquaRail_"]) {
        return @"冲锋艇";
    }
    if ([物资 containsString:@"ny.01"]) {
        return @"皮卡车";
    }
    if ([物资 containsString:@"Destru"]) {
        return @"汽油";
    }
    if ([物资 containsString:@"CoupeRB"] || [物资 containsString:@"Rado"]) {
        return @"双座跑车";
    }
    if ([物资 containsString:@"SciFi_Moto"]) {
        return @"波波球";
    }
    
    if ([物资 containsString:@"PickUpListWrapperActor"]) {
        return @"骨灰盒";
    }
    
    if ([物资 containsString:@"DropPlane"]) {
        return @"空投飞机";
    }
    if ([物资 containsString:@"AirDrop"]) {
        return @"[好东西]空投箱";
    }
    
    if ([物资 containsString:@"BRDM"]) {
        return @"装甲车";
    }
    if ([物资 containsString:@"PG117"]) {
        return @"大船";
    }
    //枪械
    if ([物资 containsString:@"M416"]) {
        return @"M416";
    }
    if ([物资 containsString:@"M417"]) {
        return @"[好东西]M417";
    }
    if ([物资 containsString:@"VAL"]) {
        return @"VAL";
    }
    if ([物资 containsString:@"AKM"]) {
        return @"AKM";
    }
    if ([物资 containsString:@"AUG"]) {
        return @"AUG";
    }
    if ([物资 containsString:@"Groza"]) {
        return @"[好东西]Groza";
    }
    if ([物资 containsString:@"M16A4"]) {
        return @"M16A4";
    }
    if ([物资 containsString:@"SKS"]) {
        return @"SKS";
    }
    if ([物资 containsString:@"VSS"]) {
        return @"VSS";
    }
    if ([物资 containsString:@"AWM"]) {
        return @"[好东西]AWM";
    }
    
    if ([物资 containsString:@"AMR"]) {
        return @"[好东西]AMR";
    }
    if ([物资 containsString:@"UMP"]) {
        return @"UMP45";
    }
    if ([物资 containsString:@"DP28"]) {
        return @"大盘鸡";
    }
    if ([物资 containsString:@"Vector"]) {
        return @"维克托";
    }
    if ([物资 containsString:@"M762"]) {
        return @"M762";
    }
    if ([物资 containsString:@"M249"]) {
        return @"M249";
    }
    if ([物资 containsString:@"M24"]) {
        return @"M24";
    }
    if ([物资 containsString:@"SCAR"]) {
        return @"SCAR-L";
    }
    if ([物资 containsString:@"QBZ"]) {
        return @"QBZ";
    }
    if ([物资 containsString:@"MG3"]) {
        return @"[好东西]MG3";
    }
    if ([物资 containsString:@"98"]) {
        return @"Kar98k";
    }
    if ([物资 containsString:@"Mini14"]) {
        return @"Mini14";
    }
    if ([物资 containsString:@"Mk14"]) {
        return @"Mk14";
    }
    if ([物资 containsString:@"P90"]) {
        return @"[好东西]P90CG17";
    }
    if ([物资 containsString:@"revivalAED"]) {
        return @"[好东西]自救器";
    }
    
    //防具 背包P90CG17
    if ([物资 containsString:@"Helmet_Lv2"]) {
        return @"二级头";
    }
    if ([物资 containsString:@"Armor_Lv2"]) {
        return @"二级甲";
    }
    if ([物资 containsString:@"Bag_Lv2"]) {
        return @"二级包";
    }
    if ([物资 containsString:@"Bag_Lv3"]) {
        return @"[好东西]三级包";
    }
    if ([物资 containsString:@"Helmet_Lv3"]) {
        return @"[好东西]三级头";
    }
    if ([物资 containsString:@"Armor_Lv3"]) {
        return @"[好东西]三级甲";
    }
    //倍镜
    if ([物资 containsString:@"MZJ_2X"]) {
        return @"2倍瞄准镜";
    }
    if ([物资 containsString:@"MZJ_3X"]) {
        return @"3倍瞄准镜";
    }
    if ([物资 containsString:@"MZJ_4X"]) {
        return @"[好东西]4倍瞄准镜";
    }
    if ([物资 containsString:@"MZJ_6X"]) {
        return @"[好东西]6倍瞄准镜";
    }
    if ([物资 containsString:@"MZJ_8X"]) {
        return @"[好东西]8倍瞄准镜";
    }
    if ([物资 containsString:@"QX_Pickup"]) {
        return @"全息";
    }
    if ([物资 containsString:@"MZJ_HD_Pickup"]) {
        return @"红点";
    }
    //配件 DJ_Sniper_Q_Pickup
    if ([物资 containsString:@"DJ_Sniper_Q_Pickup"]) {
        return @"狙击快速弹夹";
    }
    if ([物资 containsString:@"QK_Sniper_Compensator"]) {
        return @"狙击补偿";
    }
    if ([物资 containsString:@"QK_Sniper_FlashHider"]) {
        return @"狙击消焰器";
    }
    if ([物资 containsString:@"QK_Sniper_FlashHider"]) {
        return @"狙击消焰器";
    }
    if ([物资 containsString:@"Large_FlashHider"]) {
        return @"步枪消焰器";
    }
    if ([物资 containsString:@"DJ_Large_Q_Pickup"]) {
        return @"步枪快速弹夹";
    }
    if ([物资 containsString:@"Mid_Suppressor"]) {
        return @"冲锋枪消音";
    }
    else if ([物资 containsString:@"QT_Sniper_Pickup"]) {
        return @"托腮板";
    }
    if ([物资 containsString:@"Mid_Compensator"]) {
        return @"冲锋枪补偿器";
    }
    if ([物资 containsString:@"Large_Compensator"]) {
        return @"步枪补偿器";
    }
    if ([物资 containsString:@"BP_QT_UZI_Pickup_C"]) {
        return @"UZI枪托";
    }
    if ([物资 containsString:@"BP_QT_A_Pickup_C"]) {
        return @"战术枪托";
    }
    if ([物资 containsString:@"BP_WB_LightGrip_Pickup_C"]) {
        return @"轻型握把";
    }
    if ([物资 containsString:@"Large_E_Pickup"]) {
        return @"步枪扩容";
    }
    if ([物资 containsString:@"Sniper_Suppressor"]) {
        return @"狙击消音器";
    }
    if ([物资 containsString:@"Vertical_Pickup"]) {
        return @"垂直握把";
    }
    if ([物资 containsString:@"HalfGrip_Pickup"]) {
        return @"半截红握把";
    }
    if ([物资 containsString:@"LightGrip_Pickup"]) {
        return @"轻型握把";
    }
    if ([物资 containsString:@"Angled_Pickup"]) {
        return @"直角前握把";
    }
    if ([物资 containsString:@"Angled_Pickup"]) {
        return @"直角前握把";
    }
    
    //子弹 LightGrip_Pickup
    if ([物资 containsString:@"BP_Ammo_762mm_Pickup_C"]) {
        return @"[子弹]762";
    }
    if ([物资 containsString:@"BP_Ammo_556mm_Pickup_C"]) {
        return @"[子弹]556";
    }
    if ([物资 containsString:@"BP_Ammo_9mm_Pickup_C"]) {
        return @"[子弹]9毫米";
    }
    if ([物资 containsString:@".45"]) {
        return @"[子弹].45";
    }
    if ([物资 containsString:@".50"]) {
        return @"[子弹]AWM";
    }
    //药品
    if ([物资 containsString:@"Injection_Pickup_C"]) {
        return @"肾上腺素";
    }
    if ([物资 containsString:@"Firstaid_Pickup"]) {
        return @"急救包";
    }
    if ([物资 containsString:@"FirstAidbox"]) {
        return @"医疗箱";
    }
    if ([物资 containsString:@"Drink"]) {
        return @"能量饮料";
    }
    if ([物资 containsString:@"Painkiller"]) {
        return @"止疼药";
    }
    if ([物资 containsString:@"Bandage"]) {
        return @"绷带";
    }
    
    //雷
    if ([物资 containsString:@"Grenade_Shoulei_Weapon"]) {
        return @"手雷";
    }
    if ([物资 containsString:@"ProjFire"]) {
        return @"闪光弹";
    }
    if ([物资 containsString:@"ProjBurn"]) {
        return @"燃烧瓶";
    }
    return @"";
    
    
}
-(void)写数据:(NSString*)str file:(NSString*)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    //获取文件路径
    NSString*theFilePath = [paths objectAtIndex:0];
    //如果文件不存在 创建文件
    NSString*FilePath = [theFilePath stringByAppendingPathComponent:file];
    
    [str writeToFile:FilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
