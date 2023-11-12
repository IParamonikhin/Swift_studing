//
//  ViewController.swift
//  final_unit41
//
//  Created by Иван on 12.11.2023.
//

import UIKit
import SnapKit
import AVKit

class ViewController: UIViewController {

    var model = Model()
    let tableView = UITableView()
    var tableViewDatasource : TableViewDelegateAndDataSource?
    var playerControl: AVPlayerViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
    }
}

private extension ViewController{
    
    func initialize() {
        
        tableViewDatasource = TableViewDelegateAndDataSource(model: model)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.rowHeight = 200
        tableView.backgroundColor = UIColor(named: "backgroundColorAsset")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self.tableViewDatasource
        tableView.delegate = self.tableViewDatasource
        
        tableViewDatasource!.selectedCallback = { indexPath in
            self.videoPlayerStart(indexPath.row)
        }
    }
    
    func videoPlayerStart(_ episodeNumder: Int){
        let player = AVPlayer(url: model.episodeURL(episodeNumber: episodeNumder))
        playerControl = AVPlayerViewController()
        playerControl.player = player
        playerControl.player?.play()
        
        present(playerControl, animated: true)
        
    }
}
