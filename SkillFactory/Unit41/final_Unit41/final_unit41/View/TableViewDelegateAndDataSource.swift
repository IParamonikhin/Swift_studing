//
//  TableViewDelegateAndDataSource.swift
//  final_unit41
//
//  Created by Иван on 12.11.2023.
//

import Foundation
import UIKit

class TableViewDelegateAndDataSource: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var model: Model!
    var selectedCallback : ((IndexPath)->Void)?
    
    init(model: Model) {
        self.model = model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.episodeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.configure(episodeName: model.episodeName(episodeNumber: indexPath.row), url: model.episodeURL(episodeNumber: indexPath.row), thumbnailTimspot: model.thumbnailTiming[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let callback = selectedCallback {
            callback(indexPath)
        }
    }
    
}
