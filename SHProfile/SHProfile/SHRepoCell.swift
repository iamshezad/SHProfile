//
//  SHRepoCell.swift
//  SHProfile


import UIKit

class SHRepoCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoDesc: UILabel!
    @IBOutlet weak var repoLang: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
