//
//  WampCraAuthHelper.swift
//  Pods
//
//  Created by Yossi Abraham on 31/08/2016.
//
//

import Foundation
import CommonCrypto

open class SwampCraAuthHelper {
    
    private func hmac(input: String, key: Data) -> Data {
        let inputBytes = input.cString(using: .utf8)
        let inputLength = input.lengthOfBytes(using: .utf8)
        var output = Data(count: Int(CC_SHA1_DIGEST_LENGTH))

        let _ = output.withUnsafeMutableBytes { outBytes in
            key.withUnsafeBytes { keyBytes in
                //void CCHmac(CCHmacAlgorithm algorithm, const void *key, size_t keyLength, const void *data, size_t dataLength, void *macOut);
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyBytes, key.count, inputBytes, inputLength, outBytes);
            }
        }

        return output
    }
    
    
    /*
 private func hmac(string: NSString, key: NSData) -> NSData {
 let keyBytes = UnsafePointer<CUnsignedChar>(key.bytes)
 let data = string.cStringUsingEncoding(NSUTF8StringEncoding)
 let dataLen = Int(string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
 let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
 let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
 CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyBytes, key.length, data, dataLen, result);
 return NSData(bytes: result, length: digestLen)
 }
 */
    
//    open static func sign(_ secret: String, challenge: String) -> String {
//        let hmac: Array<UInt8> = try! CryptoSwift.HMAC(key: secret.utf8.map {$0}, variant: .sha256).authenticate(challenge.utf8.map {$0})
//        return hmac.toBase64()!
//    }
}
