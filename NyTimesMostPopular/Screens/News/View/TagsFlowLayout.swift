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
                //we use it as rule for margin
                trailingMarginSum = sectionInset.left
            } else {
                //we sum all the previous calculated margin
                attribute.frame.origin.x = trailingMarginSum
            }
            
            //each iteraction we sum the width of the actual cell and also sum the spacing in order to prevent
            //the cells of being glued to each other
            trailingMarginSum += attribute.frame.width + minimumInteritemSpacing
        }
        
        return actualAttributes
    }
    
}
