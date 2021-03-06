//
//  NSString+SHAEncryption.m
//  TimeTesting
//
//  Created by William L. Schreiber on 1/2/14.
//  Copyright (c) 2014 Bus Productions. All rights reserved.
//

#import "NSString+SHAEncryption.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (SHAEncryption)
-(NSString*)shaEncrypted
{
   unsigned char digest[CC_SHA1_DIGEST_LENGTH];
   NSData *stringBytes = [self dataUsingEncoding: NSUTF8StringEncoding]; /* or some other encoding */
   if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
      /* SHA-1 hash has been calculated and stored in 'digest'. */
      NSMutableString* sha512 = [[NSMutableString alloc] init];
      for (int i = 0 ; i < CC_SHA1_DIGEST_LENGTH ; ++i)
      {
         [sha512 appendFormat: @"%02x", digest[i]];
      }
      return (NSString*)sha512;
   }
   return self;
}
@end
