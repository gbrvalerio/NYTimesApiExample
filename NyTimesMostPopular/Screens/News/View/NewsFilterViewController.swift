//
//  NewsFilterViewController.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 06/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class NewsFilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: - IBOutlets
    @IBOutlet private weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var sectionTagsCollectionView: UICollectionView!
    
    private let helperCell = NewsSectionCollectionViewCell.nib?.instantiate(withOwner: nil, options: nil).first as! NewsSectionCollectionViewCell
    
    var selectedSection:NewsSection = .all {
        didSet {
            guard sectionTagsCollectionView != nil else { return }
            
            updateSelectedSection(oldValue, selectedSection)
        }
    }
    
    var selectedTimePeriod:NewsTimePeriod = .week {
        didSet {
            guard sectionTagsCollectionView != nil else { return }
            
            updateSelectedTimePeriod(oldValue, selectedTimePeriod)
        }
    }
    
    var onUserDidUpdateFilter:((NewsSection, NewsTimePeriod) -> Void)?
    var onDismiss:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionTagsCollectionView.register(NewsSectionCollectionViewCell.nib, forCellWithReuseIdentifier: NewsSectionCollectionViewCell.identifier)
        
        updateSelectedTimePeriod(selectedTimePeriod, selectedTimePeriod)
    }
    
    private func updateSelectedTimePeriod(_ oldValue:NewsTimePeriod, _ newValue:NewsTimePeriod) {
        guard
            let newSelectedArrayIndex = NewsTimePeriod.allCases.index(of: newValue)
        else {
            return
        }
        
        let newSelectedIndex = NewsTimePeriod.allCases.startIndex.distance(to: newSelectedArrayIndex)
        
        DispatchQueue.main.async {
            self.timeSegmentedControl.selectedSegmentIndex = newSelectedIndex
        }
    }
    
    private func updateSelectedSection(_ oldValue:NewsSection, _ newValue:NewsSection) {
        //the reason for all this tricky game is to avoid calling
        //collectionView.reloadData() which would spend a lot more of processing power
        //anyway, its just parsing.
        guard
            oldValue != newValue,
            let actualSelectedIndex = NewsSection.allCases.index(of: oldValue),
            let newSelectedIndex = NewsSection.allCases.index(of: newValue)
        else {
            return
        }
        
        let actualSelectedRow = NewsSection.allCases.startIndex.distance(to: actualSelectedIndex)
        let newSelectedRow = NewsSection.allCases.startIndex.distance(to: newSelectedIndex)
        
        let selectedIndexPath = IndexPath(row: actualSelectedRow, section: 0)
        let newSelectedIndexPath = IndexPath(row: newSelectedRow, section: 0)
        
        
        DispatchQueue.main.async {
            //the update animation breaks the flowlayout
            //so we perform the update without animating
            UIView.performWithoutAnimation {
                self.sectionTagsCollectionView.reloadItems(at: [selectedIndexPath, newSelectedIndexPath])
            }
        }
    }
    
    //MARK: - UserInput
    @IBAction private func onDoneButton(_ sender: Any) {
        let selectedTimePeriod = NewsTimePeriod.allCases[timeSegmentedControl.selectedSegmentIndex]
        onUserDidUpdateFilter?(selectedSection, selectedTimePeriod)
        self.navigationController?.dismiss(animated: true, completion: onDismiss)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: onDismiss)
    }
    
    //MARK: - Collection View Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSectionCollectionViewCell.identifier, for: indexPath) as! NewsSectionCollectionViewCell
        let cellSection = NewsSection.allCases[indexPath.row]

        cell.section = cellSection
        cell.isSelectedSection = cellSection == selectedSection
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //sets the section
        helperCell.section = NewsSection.allCases[indexPath.row]
        //lets the system calculates the needed size based on the section
        return helperCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSection = NewsSection.allCases[indexPath.row]
    }
}
