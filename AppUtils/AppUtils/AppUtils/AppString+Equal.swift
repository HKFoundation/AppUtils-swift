//
//  AppString+Equal.swift
//  AppUtils
//
//  Created by bormil on 2020/4/17.
//  Copyright © 2020 深眸科技（北京）有限公司. All rights reserved.
//

import Foundation
import UIKit

extension String {
    private static func regexCommon(common: String, value: String) -> Bool {
        let regex: NSPredicate = NSPredicate(format: "SELF MATCHES %@", common)
        return regex.evaluate(with: value)
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回当前设备型号
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回当前设备型号
    static func regexTypeOfMachine() -> String {
        var info = utsname()
        uname(&info)
        var mode = ""
        #if targetEnvironment(simulator)
            mode = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
            mode = withUnsafePointer(to: &info.machine.0) { p in
                String(cString: p)
            }
        #endif

        switch mode {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE 2"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,6": return "iPhone SE 3"
        case "iPhone14,7": return "iPhone 14"
        case "iPhone14,8": return "iPhone 14 Plus"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone15,4": return "iPhone 15"
        case "iPhone15,5": return "iPhone 15 Plus"
        case "iPhone16,1": return "iPhone 15 Pro"
        case "iPhone16,2": return "iPhone 15 Pro Max"
        case "iPhone17,1": return "iPhone 16 Pro"
        case "iPhone17,2": return "iPhone 16 Pro Max"
        case "iPhone17,3": return "iPhone 16"
        case "iPhone17,4": return "iPhone 16 Plus"
        case "iPhone17,5": return "iPhone 16e"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"
        case "iPad6,11", "iPad6,12": return "iPad 5"
        case "iPad7,1", "iPad7,2": return "iPad Pro 12.9 inch 2nd gen"
        case "iPad7,3", "iPad7,4": return "iPad Pro 10.5 inch"
        case "iPad7,5", "iPad7,6": return "iPad 6"
        case "iPad7,11", "iPad7,12": return "iPad 7"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro 11-inch"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro 12.9-inch 3rd gen"
        case "iPad8,9", "iPad8,10": return "iPad Pro 11-inch 2nd gen"
        case "iPad8,11", "iPad8,12": return "iPad Pro 12.9-inch 4th gen"
        case "iPad11,1", "iPad11,2": return "iPad Mini 5"
        case "iPad11,3", "iPad11,4": return "iPad Air 3"
        case "iPad11,6", "iPad11,7": return "iPad 8"
        case "iPad13,1", "iPad13,2": return "iPad Air 4"
        case "iPad12,1", "iPad12,2": return "iPad 9"
        case "iPad14,1", "iPad14,2": return "iPad Mini 6"
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return "iPad Pro 11-inch 3rd gen"
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return "iPad Pro 12.9-inch 5th gen"
        case "iPad13,16", "iPad13,17": return "iPad Air 5"
        case "iPad13,18", "iPad13,19": return "iPad 10"
        case "iPad14,3", "iPad14,4": return "iPad Pro 11-inch 4th gen"
        case "iPad14,5", "iPad14,6": return "iPad Pro 12.9-inch 6th gen"
        case "iPad14,8", "iPad14,9": return "iPad Air 6th Gen"
        case "iPad14,10", "iPad14,11": return "iPad Air 7th Gen"
        case "iPad16,3", "iPad16,4": return "iPad Pro 11 inch 5th Gen"
        case "iPad16,5", "iPad16,6": return "iPad Pro 12.9 inch 7th Gen"
        default: return ""
        }
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示当前设备是否是留海屏
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示当前设备是否是留海屏
    static func AppiPhoneX() -> Bool {
        let mode = ["iPhone X",
                    "iPhone XR",
                    "iPhone XS",
                    "iPhone XS Max",
                    "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max",
                    "iPhone 12 mini", "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max",
                    "iPhone 13 mini", "iPhone 13", "iPhone 13 Pro", "iPhone 13 Pro Max",
                    "iPhone 14", "iPhone 14 Plus", "iPhone 14 Pro", "iPhone 14 Pro Max",
                    "iPhone 15", "iPhone 15 Plus", "iPhone 15 Pro", "iPhone 15 Pro Max",
                    "iPhone 16", "iPhone 16 Plus", "iPhone 16 Pro", "iPhone 16 Pro Max", "iPhone 16e"]

        if mode.contains(self.regexTypeOfMachine()) {
            return true
        }
        return false
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示纯数字是否有效
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示纯数字是否有效
    static func regexDigit(digit: String) -> Bool {
        let regex = "^[0-9]*$"
        return self.regexCommon(common: regex, value: digit)
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示邮箱是否有效
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示邮箱是否有效
    static func regexEmail(email: String) -> Bool {
        let regex = "[A-Za-z0-9._%+-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.regexCommon(common: regex, value: email)
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示手机号码是否有效
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示手机号码是否有效
    static func regexPhone(phone: String) -> Bool {
        let regex = "^1((3[0-9]|4[0-9]|5[0-9]|6[5-7]|7[0-9]|8[0-9]|9[0-9])\\d{8}|((34[0-8]|349|47|49|48|50|51|52|57|58|59|78|81|89|90|91|98|99)\\d{8}|1349\\d{7}|141\\d{8}|149\\d{8}|165\\d{8}|167\\d{8}|162\\d{8}|170[0-9]\\d{7}|171\\d{8}|172\\d{8}|173\\d{8}|174[0-2]\\d{8}|174[6-9]\\d{8}|1740[0-5]\\d{6}|175\\d{8}|176\\d{8}|177\\d{8}|178\\d{8}|179\\d{8}|180\\d{8}|181\\d{8}|182\\d{8}|183\\d{8}|184\\d{8}|185\\d{8}|186\\d{8}|187\\d{8}|188\\d{8}|189\\d{8}|190\\d{8}|191\\d{8}|192\\d{8}|193\\d{8}|195\\d{8}|196\\d{8}|197\\d{8}|198\\d{8}|199\\d{8}))$"
        return self.regexCommon(common: regex, value: phone)
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示车牌号码是否有效
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示车牌号码是否有效
    static func regexCar(car: String) -> Bool {
        let regex = "^(京[A-HJ-NPQY]|沪[A-HJ-N]|津[A-HJ-NPQR]|渝[A-DFGHN]|冀[A-HJRST]|晋[A-FHJ-M]|蒙[A-HJKLM]|辽[A-HJ-NP]|吉[A-HJK]|黑[A-HJ-NPR]|苏[A-HJ-N-U]|浙[A-HJKL]|皖[A-HJ-NP-S]|闽[A-HJK]|赣[A-HJKLMS]|鲁[A-HJ-NP-SUVWY]|豫[A-HJ-NP-SU]|鄂[A-HJ-NP-S]|湘[A-HJ-NSU]|粤[A-HJ-NP-Y]|桂[A-HJ-NPR]|琼[A-F]|川[A-HJ-MQ-Z]|贵[A-HJ]|云[AC-HJ-NP-SV]|藏[A-HJ]|陕[A-HJKV]|甘[A-HJ-NP]|青[A-H]|宁[A-E]|新[A-HJ-NP-S])([0-9A-HJ-NP-Z]{4}[0-9A-HJ-NP-Z挂试]|[0-9]{4}学|[A-D0-9][0-9]{3}警|[DF][0-9A-HJ-NP-Z][0-9]{4}|[0-9]{5}[DF])$|^WJ[京沪津渝冀晋蒙辽吉黑苏浙皖闽赣鲁豫鄂湘粤桂琼川贵云藏陕甘青宁新]?[0-9]{4}[0-9JBXTHSD]$|^(V[A-GKMORTV]|K[A-HJ-NORUZ]|H[A-GLOR]|[BCGJLNS][A-DKMNORVY]|G[JS])[0-9]{5}$|^[0-9]{6}使$|^([沪粤川渝辽云桂鄂湘陕藏黑]A|闽D|鲁B|蒙[AEH])[0-9]{4}领$|^粤Z[0-9A-HJ-NP-Z][0-9]{3}[港澳]$"
        return self.regexCommon(common: regex, value: car)
    }

    /* ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*
     * // MARK: 返回布尔值表示身份证号码是否有效
     * ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄＊ ┄┅┄┅┄┅┄┅┄*/

    /// 返回布尔值表示身份证号码是否有效
    static func regexCard(card: String) -> Bool {
        /// 1.如果身份证号码不满足15位或18位，返回false
        if card.count != 15 && card.count != 18 {
            return false
        }

        /// 身份证号码省份编码
        let code = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
        /// 2.如果省份编码不存在，返回false
        if !code.contains(String(card.prefix(2))) {
            return false
        }

        /// 加权因子
        let r = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        /// 校验码 ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
        let checks = [49, 48, 88, 57, 56, 55, 54, 53, 52, 51, 50]
        /// 3.将15位身份证号码转换成18位
        var computed = card
        if card.count == 15 {
            computed.insert(contentsOf: "19", at: computed.index(computed.startIndex, offsetBy: 6))
            var p = 0
            let digit = computed.utf8CString

            for index in 0 ... 16 {
                p += Int(digit[index] - 48) * r[index]
            }
            let obj = String(format: "%c", checks[p % 11])
            computed.insert(contentsOf: obj, at: computed.index(computed.startIndex, offsetBy: computed.count))
        }

        /// 4.如果生日日期无效，返回false
        let birthday = computed[computed.index(computed.startIndex, offsetBy: 6) ..< computed.index(computed.startIndex, offsetBy: 14)]
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"

        guard formatter.date(from: String(birthday)) != nil else {
            return false
        }

        /// 5.如果不是18位，返回false
        guard strlen(computed) == 18 else {
            return false
        }

        /// 6.如果前17位包含非数字或18位非 X或x，返回false
        let digit = computed.utf8CString
        var verifyCode = 0

        for index in 0 ... 18 {
            if isdigit(Int32(digit[index])) == 0 && !(88 == digit[index] || 120 == digit[index]) && 17 == index {
                return false
            }

            if index <= 16 {
                verifyCode += Int(digit[index] - 48) * r[index]
            }
        }

        /// 7.如果校验码位不正确，返回false
        if checks[verifyCode % 11] != digit[17] {
            return false
        }

        return true
    }
}
