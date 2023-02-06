//
//  PostTableViewCell.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postCreatedAtLabel: UILabel!
    
    //MARK: - Variables
    var hit : Hits? {
        didSet {
            setupData()
        }
    }
    
    //MARK: - Lifecycle method -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let created_at = hit?.created_at,  let date = formatter.date(from: created_at) {
            formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            postCreatedAtLabel.text = formatter.string(from: date)
        }
        postTitleLabel.text = hit?.title
    }
    
}
