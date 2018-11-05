//
//  WXContacts.h
//  PoemKing
//
//  Created by Leon Guo on 2018/11/2.
//  Copyright © 2018 Leon Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXContacts : NSObject

@property (nonatomic, copy)NSString *userName;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)NSInteger certificationFlag;
@property (nonatomic, assign)NSInteger imgStatus;
@property (nonatomic, copy)NSString *encodeUserName;
@property (nonatomic, strong)NSData *dbContactLocal;
@property (nonatomic, strong)NSData *dbContactOther;
@property (nonatomic, strong)NSData *dbContactRemark;
@property (nonatomic, strong)NSData *dbContactHeadImage;
@property (nonatomic, strong)NSData *dbContactProfile;
@property (nonatomic, strong)NSData *dbContactSocial;
@property (nonatomic, strong)NSData *dbContactChatRoom;
@property (nonatomic, strong)NSData *dbContactBrand;
@property (nonatomic, strong)NSData *packed_DBContactTable;
@property (nonatomic, strong)NSData *dbContactOpenIM;
@property (nonatomic, assign)NSInteger extFlag;
@property (nonatomic, copy)NSString *openIMAppid;



@end

NS_ASSUME_NONNULL_END
