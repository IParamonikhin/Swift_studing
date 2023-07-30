//
//  EventsListTableViewCell.swift
//  EventViewer
//
//  Created by Иван on 03.09.2023.
//

import UIKit

class EventsListTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let titleLabel = UILabel()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview()
        addConstraints()

        // Configure the view for the selected state
    }

}

private extension EventsListTableViewCell {
    
    func addSubview() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.leading.trailing.equalTo(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(30)
            make.leading.trailing.equalTo(20)
        }
    }
}
