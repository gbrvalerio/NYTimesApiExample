//
//  NewsSectionCollectionViewCell.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 06/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

private let kDefaultSelectedColor = UIColor(red: 0.0, green: 0.4784, blue: 1.0, alpha: 1.0)
private let kDefaultDeselectedColor = UIColor(white: 0.8, alpha: 1.0)

class NewsSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    static var nib:UINib? {
        return UINib(nibName: "NewsSectionCollectionViewCell", bundle: .main)
    }
    
    static var identifier:String {
        return String(describing: type(of: NewsSectionCollectionViewCell.self))
    }
    
    var isSelectedSection:Bool = false {
        didSet {
            if isSelectedSection {
                self.containerView.backgroundColor = kDefaultSelectedColor
                self.tagLabel.textColor = kDefaultDeselectedColor
            } else {
                self.containerView.backgroundColor = kDefaultDeselectedColor
                self.tagLabel.textColor = kDefaultSelectedColor
            }
        }
    }
    
    var section:NewsSection {
        set {
            if newValue == .all {
                //as the rawValue of .all is all-sections, putting simply All
                //is better for visualization
                tagLabel.text = "All"
            } else if newValue == .membercenter {
                tagLabel.text = "Member Center"
            } else if newValue == .nyRegion {
                tagLabel.text = "N.Y. / Region"
            } else {
                tagLabel.text = newValue.rawValue
            }
        }
        get {
            return NewsSection(rawValue: tagLabel.text ?? "") ?? .all
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 4
        isSelectedSection = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        section = .all
        isSelectedSection = false
    }

}
