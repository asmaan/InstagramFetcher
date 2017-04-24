//
//  String+TextHeight.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import Foundation
import UIKit
extension String {
    // MARK: Calculate Height based on text Length
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
