#include <stdio.h>
#include <yy.h>
#import <mach-o/dyld.h>
#import <mach/mach.h>
#include <sys/sysctl.h>
#import <string.h>
#include <string>
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>

extern "C" kern_return_t mach_vm_region_recurse(
                                                vm_map_t                 map,
                                                mach_vm_address_t        *address,
                                                mach_vm_size_t           *size,
                                                uint32_t                 *depth,
                                                vm_region_recurse_info_t info,
                                                mach_msg_type_number_t   *infoCnt);
#pragma mark 读取get_task
mach_port_t task;
int get_Pid(NSString* GameName) {
    size_t length = 0;
    static const int name[] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    int err = sysctl((int *)name, (sizeof(name) / sizeof(*name)) - 1, NULL, &length, NULL, 0);
    if (err == -1) err = errno;
    if (err == 0) {
        struct kinfo_proc *procBuffer = (struct kinfo_proc *)malloc(length);
        if(procBuffer == NULL) return -1;
        sysctl((int *)name, (sizeof(name) / sizeof(*name)) - 1, procBuffer, &length, NULL, 0);
        int count = (int)length / sizeof(struct kinfo_proc);
        for (int i = 0; i < count; ++i) {
            const char *procname = procBuffer[i].kp_proc.p_comm;
            NSString *进程名字=[NSString stringWithFormat:@"%s",procname];
            pid_t pid = procBuffer[i].kp_proc.p_pid;
            //自己写判断进程名 和平精英
            if([进程名字 containsString:GameName])
            {
                return pid;
            }
        }
    }
    
    return  -1;
}
long get_base_address(NSString* GameName) {
    vm_map_offset_t vmoffset = 0;
    vm_map_size_t vmsize = 0;
    uint32_t nesting_depth = 0;
    struct vm_region_submap_info_64 vbr;
    mach_msg_type_number_t vbrcount = 16;
    pid_t pid =get_Pid(GameName);
    
    kern_return_t kret = task_for_pid(mach_task_self(), pid, &task);
    if (kret == KERN_SUCCESS) {
        mach_vm_region_recurse(task, &vmoffset, &vmsize, &nesting_depth, (vm_region_recurse_info_t)&vbr, &vbrcount);
        return vmoffset;
    }
    return 0;
}
#pragma mark 读取内存

bool RRDVGF(long Src,int Size,void* Dst)
{

    vm_size_t size = 0;
    
    kern_return_t error = vm_read_overwrite(task, (vm_address_t)Src, Size, (vm_address_t)Dst, &size);
    if(error != KERN_SUCCESS || size != Size) {
        return false;
    }
    return true;
   
}

template<typename T> T defrgfas(long address) {
    T data;
    RRDVGF(address, sizeof(T),reinterpret_cast<void *>(&data));
    return data;
}
#pragma mark 矩阵到向量
static 最小视图信息 POV;
VV3 MatrixToVector(矩阵 matrix) {
    @autoreleasepool {
        
        return VV3(matrix[3][0], matrix[3][1], matrix[3][2]);
    }
    
}
#pragma mark 矩阵
矩阵 MatrixMulti(矩阵 m1, 矩阵 m2) {
    @autoreleasepool {
        矩阵 matrix = 矩阵();
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                for (int k = 0; k < 4; k++) {
                    matrix[i][j] += m1[i][k] * m2[k][j];
                }
            }
        }
        return matrix;
    }
    
}
#pragma mark 变换矩阵
矩阵 TransformToMatrix(转换 transform ,最小视图信息 STPOV) {
    @autoreleasepool {
        POV=STPOV;
        矩阵 matrix;
        matrix[3][0] = transform.Translation.X;
        matrix[3][1] = transform.Translation.Y;
        matrix[3][2] = transform.Translation.Z;
        
        float x2 = transform.Rotation.x + transform.Rotation.x;
        float y2 = transform.Rotation.y + transform.Rotation.y;
        float z2 = transform.Rotation.z + transform.Rotation.z;
        
        float xx2 = transform.Rotation.x * x2;
        float yy2 = transform.Rotation.y * y2;
        float zz2 = transform.Rotation.z * z2;
        
        matrix[0][0] = (1.0f - (yy2 + zz2)) * transform.Scale3D.X;
        matrix[1][1] = (1.0f - (xx2 + zz2)) * transform.Scale3D.Y;
        matrix[2][2] = (1.0f - (xx2 + yy2)) * transform.Scale3D.Z;
        
        float yz2 = transform.Rotation.y * z2;
        float wx2 = transform.Rotation.w * x2;
        matrix[2][1] = (yz2 - wx2) * transform.Scale3D.Z;
        matrix[1][2] = (yz2 + wx2) * transform.Scale3D.Y;
        
        float xy2 = transform.Rotation.x * y2;
        float wz2 = transform.Rotation.w * z2;
        matrix[1][0] = (xy2 - wz2) * transform.Scale3D.Y;
        matrix[0][1] = (xy2 + wz2) * transform.Scale3D.X;
        
        float xz2 = transform.Rotation.x * z2;
        float wy2 = transform.Rotation.w * y2;
        matrix[2][0] = (xz2 + wy2) * transform.Scale3D.Z;
        matrix[0][2] = (xz2 - wy2) * transform.Scale3D.X;
        
        matrix[0][3] = 0;
        matrix[1][3] = 0;
        matrix[2][3] = 0;
        matrix[3][3] = 1;
        
        return matrix;
    }
    
}
#pragma mark 旋转矩阵
矩阵 RotatorToMatrix(FRotator rotation) {
    @autoreleasepool {
        float radPitch = rotation.Pitch * ((float) M_PI / 180.0f);
        float radYaw = rotation.Yaw * ((float) M_PI / 180.0f);
        float radRoll = rotation.Roll * ((float) M_PI / 180.0f);
        
        float SP = sinf(radPitch);
        float CP = cosf(radPitch);
        float SY = sinf(radYaw);
        float CY = cosf(radYaw);
        float SR = sinf(radRoll);
        float CR = cosf(radRoll);
        
        矩阵 matrix;
        
        matrix[0][0] = (CP * CY);
        matrix[0][1] = (CP * SY);
        matrix[0][2] = (SP);
        matrix[0][3] = 0;
        
        matrix[1][0] = (SR * SP * CY - CR * SY);
        matrix[1][1] = (SR * SP * SY + CR * CY);
        matrix[1][2] = (-SR * CP);
        matrix[1][3] = 0;
        
        matrix[2][0] = (-(CR * SP * CY + SR * SY));
        matrix[2][1] = (CY * SR - CR * SP * SY);
        matrix[2][2] = (CR * CP);
        matrix[2][3] = 0;
        
        matrix[3][0] = 0;
        matrix[3][1] = 0;
        matrix[3][2] = 0;
        matrix[3][3] = 1;
        
        return matrix;
    }
    
}
#pragma mark 世界坐标转屏幕坐标
VVV2 worldsgewF(VV3 worldLocation) {
    @autoreleasepool {
        矩阵 tempMatrix = RotatorToMatrix(POV.Rotation);
        
        VV3 vAxisX(tempMatrix[0][0], tempMatrix[0][1], tempMatrix[0][2]);
        VV3 vAxisY(tempMatrix[1][0], tempMatrix[1][1], tempMatrix[1][2]);
        VV3 vAxisZ(tempMatrix[2][0], tempMatrix[2][1], tempMatrix[2][2]);
        VV3 vDelta = worldLocation - POV.Location;
        
        VV3 vTransformed(VV3::Dot(vDelta, vAxisY), VV3::Dot(vDelta, vAxisZ), VV3::Dot(vDelta, vAxisX));
        
        if (vTransformed.Z < 1.0f) {
            vTransformed.Z = 1.f;
        }
        float fov = POV.FOV;
        float kuandu  =[UIScreen mainScreen].bounds.size.width;
        float gaodu =[UIScreen mainScreen].bounds.size.height;
        float screenCenterX = kuandu * 0.5f;
        float screenCenterY = gaodu * 0.5f;
        return VVV2(
                    (screenCenterX + vTransformed.X * (screenCenterX / tanf(fov * ((float) M_PI / 360.0f))) / vTransformed.Z),
                    (screenCenterY - vTransformed.Y * (screenCenterX / tanf(fov * ((float) M_PI / 360.0f))) / vTransformed.Z)
                    );
    }
    
}
#pragma mark 获取骨骼世界位置============================
VV3 shrgaeFW(long boneTransAddr, 矩阵 c2wMatrix){
    @autoreleasepool {
        转换 boneTrans = defrgfas<转换>(boneTransAddr);
        矩阵 boneMatrix = TransformToMatrix(boneTrans,POV);
        return MatrixToVector(MatrixMulti(boneMatrix, c2wMatrix));
    }
    
}
NSString* wewfrgfg()
{
    @autoreleasepool {
        NSString *localIP = nil;
        struct ifaddrs *addrs;
        if (getifaddrs(&addrs)==0) {
            const struct ifaddrs *cursor = addrs;
            while (cursor != NULL) {
                if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
                {
                    NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                    if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                    {
                        localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                        break;
                    }
                }
                cursor = cursor->ifa_next;
            }
            freeifaddrs(addrs);
        }
        static CFStringRef (*$MGCopyAnswer)(CFStringRef);
        void *gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
        $MGCopyAnswer = reinterpret_cast<CFStringRef (*)(CFStringRef)>(dlsym(gestalt, "MGCopyAnswer"));
        NSString*udid=(__bridge NSString *)$MGCopyAnswer(CFSTR("SerialNumber"));
        NSString*url=[NSString stringWithFormat:@"http://%@/New.html?id=%@",localIP,udid];
        UIPasteboard*pasteboard=[UIPasteboard generalPasteboard];
        [pasteboard setString:url];
        
        return udid;
    }
    
}
std::string REAWBC(int ID ,long UName) {
    if (ID < 0 || ID >= 2000000)
        return "NULL";
    if (UName > 0) {
        int IdDiv = (int)(ID / 16384);
        int Idtemp = (int)(ID % 16384);
        long NamePtr = defrgfas<long>(UName + IdDiv * 0x8);
        long Nametemp = defrgfas<long>(NamePtr + Idtemp * 0x8) + 0xe;
        char Name [64];
        RRDVGF(Nametemp,64,Name);
        return std::string(Name);
    }
    return "NULL";
}

