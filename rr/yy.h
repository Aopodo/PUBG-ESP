#import <UIKit/UIKit.h>
#include <vector>
#ifndef JFCommon_h
#define JFCommon_h

#define vvv @"6.0"
bool RRDVGF(long Src,int Size,void* Dst);
struct VVV2 {
    float X;
    float Y;

    VVV2() {
        this->X = 0;
        this->Y = 0;
    }

    VVV2(float x, float y) {
        this->X = x;
        this->Y = y;
    }

    static VVV2 Zero() {
        return VVV2(0.0f, 0.0f);
    }

    static float Distance(VVV2 a, VVV2 b) {
        VVV2 vector = VVV2(a.X - b.X, a.Y - b.Y);
        return sqrt((vector.X * vector.X) + (vector.Y * vector.Y));
    }

    bool operator!=(const VVV2 &src) const {
        return (src.X != X) || (src.Y != Y);
    }

    VVV2 &operator+=(const VVV2 &v) {
        X += v.X;
        Y += v.Y;
        return *this;
    }

    VVV2 &operator-=(const VVV2 &v) {
        X -= v.X;
        Y -= v.Y;
        return *this;
    }
};

typedef struct Circle2:public VVV2{
    float radius;
    
    Circle2():VVV2(),radius(0){}
    Circle2(float _x,float _y,float _radius):VVV2(_x,_y),radius(_radius){}

} Circle2;

struct VV3 {
    float X;
    float Y;
    float Z;

    VV3() {
        this->X = 0;
        this->Y = 0;
        this->Z = 0;
    }

    VV3(float x, float y, float z) {
        this->X = x;
        this->Y = y;
        this->Z = z;
    }

    VV3 operator+(const VV3 &v) const {
        return VV3(X + v.X, Y + v.Y, Z + v.Z);
    }

    VV3 operator-(const VV3 &v) const {
        return VV3(X - v.X, Y - v.Y, Z - v.Z);
    }

    bool operator==(const VV3 &v) {
        return X == v.X && Y == v.Y && Z == v.Z;
    }

    bool operator!=(const VV3 &v) {
        return !(X == v.X && Y == v.Y && Z == v.Z);
    }

    static VV3 Zero() {
        return VV3(0.0f, 0.0f, 0.0f);
    }

    static float Dot(VV3 lhs, VV3 rhs) {
        return (((lhs.X * rhs.X) + (lhs.Y * rhs.Y)) + (lhs.Z * rhs.Z));
    }

    static float Distance(VV3 a, VV3 b) {
        VV3 vector = VV3(a.X - b.X, a.Y - b.Y, a.Z - b.Z);
        return sqrt(((vector.X * vector.X) + (vector.Y * vector.Y)) + (vector.Z * vector.Z));
    }
};

struct 矩阵 {
    float Matrix[4][4];

    float *operator[](int index) {
        return Matrix[index];
    }
};

struct Quat {
    float x;
    float y;
    float z;
    float w;
};

struct 转换 {
    Quat Rotation;
    VV3 Translation;
    float w;
    VV3 Scale3D;
};

struct FRotator {
    float Pitch;
    float Yaw;
    float Roll;
    
    
};

struct 最小视图信息 {
    VV3 Location;
    VV3 LocationLocalSpace;
    FRotator Rotation;
    float FOV;
};

int get_pid(NSString* GameName);
VV3 MatrixToVector(矩阵 matrix);
矩阵 MatrixMulti(矩阵 m1, 矩阵 m2);
矩阵 TransformToMatrix(转换 transform ,最小视图信息 STPOV);
矩阵 RotatorToMatrix(FRotator rotation);
VVV2 worldsgewF(VV3 worldLocation);
VV3 shrgaeFW(long boneTransAddr, 矩阵 c2wMatrix);
int get_Pid(NSString* GameName);
long get_base_address(NSString* GameName);
NSString* IPFAGNEGFQDFBSG();
std::string REAWBC(int ID ,long UName);
#endif

#ifndef utf_h
#define utf_h
#define FALSE 0
#define TRUE 1

#define halfShift 10
#define UNI_SUR_HIGH_START (UTF32)0xD800
#define UNI_SUR_HIGH_END (UTF32)0xDBFF
#define UNI_SUR_LOW_START (UTF32)0xDC00
#define UNI_SUR_LOW_END (UTF32)0xDFFF
/* Some fundamental constants */
#define UNI_REPLACEMENT_CHAR (UTF32)0x0000FFFD
#define UNI_MAX_BMP (UTF32)0x0000FFFF
#define UNI_MAX_UTF16 (UTF32)0x0010FFFF
#define UNI_MAX_UTF32 (UTF32)0x7FFFFFFF
#define UNI_MAX_LEGAL_UTF32 (UTF32)0x0010FFFF

typedef unsigned char boolean;
typedef unsigned int CharType ;
typedef char UTF8;
typedef unsigned short UTF16;
typedef unsigned int UTF32;
 
static const UTF32 halfMask = 0x3FFUL;
static const UTF32 halfBase = 0x0010000UL;
static const UTF8 firstByteMark[7] = { 0x00, 0x00, static_cast<UTF8>(0xC0), static_cast<UTF8>(0xE0), static_cast<UTF8>(0xF0), static_cast<UTF8>(0xF8), static_cast<UTF8>(0xFC) };
static const UTF32 offsetsFromUTF8[6] = { 0x00000000UL, 0x00003080UL, 0x000E2080UL, 0x03C82080UL, 0xFA082080UL, 0x82082080UL };
static const char trailingBytesForUTF8[256] = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
};

typedef enum {
    strictConversion = 0,
    lenientConversion
} ConversionFlags;

typedef enum {
    conversionOK,         /* conversion successful */
    sourceExhausted,    /* partial character in source, but hit end */
    targetExhausted,    /* insuff. room in target for conversion */
    sourceIllegal,        /* source sequence is illegal/malformed */
    conversionFailed
} ConversionResult;

#endif

static int Utf16_To_Utf8 (const UTF16* sourceStart, UTF8* targetStart, size_t outLen , ConversionFlags flags) {
    int result = 0;
    const UTF16* source = sourceStart;
    UTF8* target = targetStart;
    UTF8* targetEnd    = targetStart + outLen;
    if ((NULL == source) || (NULL == targetStart)){
        // printf("ERR, Utf16_To_Utf8: source=%p, targetStart=%p\n", source, targetStart);
        return conversionFailed;
    }
    
    while (*source) {
        UTF32 ch;
        unsigned short bytesToWrite = 0;
        const UTF32 byteMask = 0xBF;
        const UTF32 byteMark = 0x80;
        const UTF16* oldSource = source; /* In case we have to back up because of target overflow. */
        ch = *source++;
        /* If we have a surrogate pair, convert to UTF32 first. */
        if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_HIGH_END) {
            /* If the 16 bits following the high surrogate are in the source buffer... */
            if ( *source ){
                UTF32 ch2 = *source;
                /* If it's a low surrogate, convert to UTF32. */
                if (ch2 >= UNI_SUR_LOW_START && ch2 <= UNI_SUR_LOW_END) {
                    ch = ((ch - UNI_SUR_HIGH_START) << halfShift) + (ch2 - UNI_SUR_LOW_START) + halfBase;
                    ++source;
                }else if (flags == strictConversion) { /* it's an unpaired high surrogate */
                    --source; /* return to the illegal value itself */
                    result = sourceIllegal;
                    break;
                }
            } else { /* We don't have the 16 bits following the high surrogate. */
                --source; /* return to the high surrogate */
                result = sourceExhausted;
                break;
            }
        } else if (flags == strictConversion) {
            /* UTF-16 surrogate values are illegal in UTF-32 */
            if (ch >= UNI_SUR_LOW_START && ch <= UNI_SUR_LOW_END){
                --source; /* return to the illegal value itself */
                result = sourceIllegal;
                break;
            }
        }
        /* Figure out how many bytes the result will require */
        if(ch < (UTF32)0x80){
            bytesToWrite = 1;
        } else if (ch < (UTF32)0x800) {
            bytesToWrite = 2;
        } else if (ch < (UTF32)0x10000) {
            bytesToWrite = 3;
        } else if (ch < (UTF32)0x110000){
            bytesToWrite = 4;
        } else {
            bytesToWrite = 3;
            ch = UNI_REPLACEMENT_CHAR;
        }
        
        target += bytesToWrite;
        if (target > targetEnd) {
            source = oldSource; /* Back up source pointer! */
            target -= bytesToWrite; result = targetExhausted; break;
        }
        switch (bytesToWrite) { /* note: everything falls through. */
            case 4: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
            case 3: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
            case 2: *--target = (UTF8)((ch | byteMark) & byteMask); ch >>= 6;
            case 1: *--target = (UTF8)(ch | firstByteMark[bytesToWrite]);
        }
        target += bytesToWrite;
    }
    return result;
}
