//
//  AppString+Utils.swift
//  AppUtils
//
//  Created by bormil on 2020/4/23.
//  Copyright © 2020 深眸科技（北京）有限公司. All rights reserved.
//

import CryptoKit
import Foundation
import UIKit

extension String {
    /// 返回 String 类型的大写加密字符串
    func md5String() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.compactMap { String(format: "%02X", $0) }.joined()
    }

    /// 返回 String 类型的大写加密字符串
    func sha256String() -> String {
        let digest = SHA256.hash(data: Data(self.utf8))
        return digest.compactMap { String(format: "%02X", $0) }.joined()
    }

    /// 通过文本字体，计算文本的宽度
    func widthForFont(font: UIFont) -> CGFloat {
        return self.sizeForFont(width: CGFloat(HUGE), height: CGFloat(HUGE), attributes: [NSAttributedString.Key.font: font]).width
    }

    /// 通过文本字体、文本宽度，计算文本的高度
    func heightForFont(font: UIFont, width: CGFloat) -> CGFloat {
        return self.sizeForFont(width: width, height: CGFloat(HUGE), attributes: [NSAttributedString.Key.font: font]).height
    }

    /// 通过文本字体、宽度和高度范围，计算文本的宽度和高度
    func sizeForFont(width: CGFloat, height: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let defaultOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let rect = self.boundingRect(with: CGSize(width: width, height: height), options: defaultOptions, attributes: attributes as [NSAttributedString.Key: Any], context: nil)
        return CGSize(width: CGFloat(Int(rect.width) + 1), height: CGFloat(Int(rect.height) + 1))
    }

    /// 返回 Float 值
    var floatValue: Float {
        return NSString(string: self).floatValue
    }

    /// 返回 Int 值
    var intValue: Int {
        return Int(NSString(string: self).intValue)
    }

    /// 返回 Data 值
    var dataValue: Data? {
        return data(using: .utf8)
    }

    /// base64 Encoded
    var base64Encoded: String {
        guard let data: Data = data(using: .utf8) else {
            return "⚠️ 字符串base64 Encoded 失败"
        }

        return data.base64EncodedString()
    }

    /// base64 Decoded
    var base64Decoded: String {
        guard let data = Data(base64Encoded: String(self), options: .ignoreUnknownCharacters), let pText = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return "⚠️ 字符串base64 Decoded 失败"
        }

        return String(describing: pText)
    }

    /// encodedURL 处理带有不合法的请求字符
    var encodedURL: String? {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
    }

    /// 从 index 开始截取字符串到结束
    func subText(from index: Int) -> String {
        guard index <= count else {
            return "⚠️ 字符串截取下标越界"
        }

        return String(self[self.index(startIndex, offsetBy: index)...])
    }

    /// 从开始截取字符串到 index 结束
    func subText(to index: Int) -> String {
        guard index <= count else {
            return "⚠️ 字符串截取下标越界"
        }

        return String(self[..<self.index(startIndex, offsetBy: index)])
    }
}
