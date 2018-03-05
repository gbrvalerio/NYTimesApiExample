//
//  NewsTableViewCell.swift
//  NyTimesMostPopular
//
//  Created by Gabriel Bezerra Valério on 05/03/18.
//  Copyright © 2018 Particular. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsBylineLabel: UILabel!
    @IBOutlet private weak var newsThumbnail: UIImageView!
    @IBOutlet private weak var newsPublishDateLabel: UILabel!
    
    public static let identifier = String(describing: type(of: NewsTableViewCell.self))
    
    public static var nib:UINib? {
        return UINib(nibName: "NewsTableViewCell", bundle: .main)
    }
    
    private var downloadTask:URLSessionDownloadTask?
    
    var newsTitle:String {
        get {
            return newsTitleLabel.text ?? ""
        }
        set {
            newsTitleLabel.text = newValue
        }
    }
    
    var newsByline:String {
        get {
            return newsBylineLabel.text ?? ""
        }
        set {
            newsBylineLabel.text = newValue
        }
    }
    
    var newsPublishDate:String {
        get {
            return newsPublishDateLabel.text ?? ""
        }
        set {
            newsPublishDateLabel.text = newValue
        }
    }
    
    func setThumbnail(url urlPath:String?) {
        downloadTask?.cancel()
        
        guard let urlPath = urlPath, let url = URL(string: urlPath) else {
            newsThumbnail.image = nil
            return
        }
        
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (imagePath, response, error) in
            guard
                error == nil,
                let imagePath = imagePath,
                let imageData = try? Data(contentsOf: imagePath),
                let thumbnail = UIImage(data: imageData)
            else {
                DispatchQueue.main.async {
                    self.newsThumbnail.image = #imageLiteral(resourceName: "warning")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.newsThumbnail.image = thumbnail
            }
        })
        downloadTask?.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTitle = ""
        newsByline = ""
        newsThumbnail.image = nil
    }

    ///Ignores the call in order to prevent the gray overlay.
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
}
