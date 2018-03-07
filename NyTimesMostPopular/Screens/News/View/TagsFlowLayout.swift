//
//  TagsFlowLayout.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 06/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class TagsFlowLayout : UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let actualAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var trailingMarginSum:CGFloat = 0.0
        actualAttributes.forEach { attribute in
            //if is the left most cell
            if attribute.frame.minX == sectionInset.left {
                trailingMarginSum = sectionInset.left
            } else {
                attribute.frame.origin.x = trailingMarginSum
            }
            
            trailingMarginSum += attribute.frame.width + minimumInteritemSpacing
        }
        
        return actualAttributes
    }
    
}
