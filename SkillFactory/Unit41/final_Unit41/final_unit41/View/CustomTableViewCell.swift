//
//  CustomTableViewCell.swift
//  final_unit41
//
//  Created by Иван on 12.11.2023.
//

import UIKit
import AVKit
import SnapKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {

    let thumbnailImageView = UIImageView()
    let playImageView = UIImageView()
    let episodeNameLabel = UILabel()
    
    func configure(episodeName: String, url: URL, thumbnailTimspot: Double){
        episodeNameLabel.text = episodeName
        thumbnailImageView.kf.setImage(with: AVAssetImageDataProvider(assetURL: url, seconds: thumbnailTimspot))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CustomTableViewCell{
    
    func initialize(){
        self.backgroundColor = .clear
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(playImageView)
        contentView.addSubview(episodeNameLabel)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        playImageView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(20)
            make.height.width.equalTo(20)
        }
        episodeNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(playImageView.snp.bottom)
            make.left.equalTo(playImageView.snp.right).offset(5)
        }
        playImageView.image = UIImage(systemName: "play.circle")
        playImageView.tintColor = .white
        
        episodeNameLabel.textColor = .white
        
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.clipsToBounds = true
    }
    
}
