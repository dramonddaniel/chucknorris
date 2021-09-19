//
//  Helpers.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

extension String {
    
    func sizeFromText(width: CGFloat, horizontalMargin: CGFloat, font: UIFont) -> CGRect {
        let size = CGSize(width: width - horizontalMargin, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    }
}
