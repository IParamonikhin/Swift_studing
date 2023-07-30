//
//  EventsListViewController.swift
//  EventViewer
//
//  Created by Ilya Kharlamov on 1/26/23.
//

import Foundation
import UIKit
import CoreData


enum KeyProperties {
    static let id = "id"
    static let createAt = "createdAt"
    static let parameters = "parameters"
}

protocol EventsListProtorol: AnyObject {
    
    
    func eventID(index: Int) -> String?
    func eventDate(index: Int) -> String?
    func reloadData(completion: @escaping () -> Void)
//    func deleteEvent(index: Int)
//    func search(searchText: String)
}

class EventsListViewController: UITableViewController {
    
    // MARK: - Outlets
    
    private var refresh = UIRefreshControl()
    private var searchController = UISearchController()
    private lazy var logoutBarButtonItem = UIBarButtonItem(
        title: "Logout",
        style: .plain,
        target: self,
        action: #selector(EventsListViewController.logout)
    )
    private lazy var addEventBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "plus"),
        style: .plain,
        target: self,
        action: #selector(EventsListViewController.addEvent)
    )
    
    
    // MARK: - Variables
    
    private var countLoadData: Int = 0
    let eventManager: EventManager
    var allEvents: [NSManagedObject] = []
    var onScrollAction: (() -> Void)?
    var onTapCell: ((Int) -> Void)?
    
    // MARK: - Lifecycle
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.allEvents = self.eventManager.events
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
        setupSearchController()
        configureUI()
        tapCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventManager.capture(.viewScreen("EVENTS_LIST"))
        reloadData()
    }
    
    // MARK: - Configuration
    
    private func tapCell() {
        onTapCell = { [weak self] index in
            guard let self else { return }
            
            guard !self.allEvents.isEmpty else { return }
            
            let detailVC = EventViewController()
            
            detailVC.indexCell = index
            detailVC.eventManager = self.eventManager
            
            let navVC = UINavigationController(rootViewController: detailVC)
            navVC.modalPresentationStyle = .fullScreen
            
            self.present(navVC, animated: true)
        
        }
    }
        
    private func reloadData(){
        reloadData{ [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func search(searchText: String) {
        
        for (index, event) in allEvents.enumerated() where
        event.value(forKey: KeyProperties.id) as? String ~= searchText {
            
            let removeItem = allEvents.remove(at: index)
            allEvents.insert(removeItem, at: 0)
        }
    }
    
    private func configureUI() {
        navigationItem.title = "Events List"
        navigationItem.rightBarButtonItem = self.logoutBarButtonItem
        navigationItem.leftBarButtonItem = self.addEventBarButtonItem
        tableView.register(EventsListTableViewCell.self, forCellReuseIdentifier: EventsListTableViewCell.identifier)
        refresh.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        tableView.refreshControl = refresh
        reloadData()
    }
    
    private func uploadData() {
        onScrollAction = { [weak self] in
            guard let self else { return }
            
            self.eventManager.getEvents(n: self.countLoadData)
            self.allEvents = self.eventManager.events
            
            if self.countLoadData < self.allEvents.count {
                self.countLoadData += 5
                self.tableView.reloadData()
            }
        }
    }
    
    @objc
    private func updateTable() {
        reloadData()
        refresh.endRefreshing()
    }
    
    // MARK: - Actions
    
    @objc
    private func logout() {
        eventManager.capture(.logout)
        let vc = LoginViewController(eventManager: eventManager)
        vc.onReloadData = { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc, animated: true)
    }
    
    @objc
    private func addEvent() {
        
        let AddEventVC = AddEventViewController()
        
        AddEventVC.eventManager = self.eventManager
        
        AddEventVC.onReloadData = { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
        
        let navVC = UINavigationController(rootViewController: AddEventVC)
        navVC.modalPresentationStyle = .fullScreen
        
        self.present(navVC, animated: true)
    }
    
}


extension EventsListViewController{
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height {
             onScrollAction?()
         }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsListTableViewCell.identifier, for: indexPath) as? EventsListTableViewCell else { fatalError("Cell nil") }
        cell.titleLabel.text = eventID(index: indexPath.row)
        cell.subtitleLabel.text = eventDate(index: indexPath.row)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if self.allEvents.isEmpty {
                return 1
            } else {
                return self.allEvents.count
            }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row, indexPath.item)
        if indexPath.row > 0 {
            if editingStyle == .delete {
                eventManager.deleteEvent(index: indexPath.row)
            }
        } else {
            eventManager.deleteEvent(index: indexPath.row)

        }
        reloadData()
      }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onTapCell?(indexPath.row)
    }
}


extension EventsListViewController: EventsListProtorol{
    
    
    func eventID(index: Int) -> String? {
        guard !self.allEvents.isEmpty else { return "Error"}
        return self.allEvents[index].value(forKey: KeyProperties.id) as? String
    }
    
    func eventDate(index: Int) -> String? {
        guard !allEvents.isEmpty else { return "00/00/0000 00:00" }
        guard let eventDate = allEvents[index].value(forKey: KeyProperties.createAt) as? Date else { return "00/00/0000 00:00" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let timeString = dateFormatter.string(from: eventDate)
        return timeString
        
    }
    
    func reloadData(completion: @escaping () -> Void) {
        eventManager.getEvents()
        allEvents = eventManager.events
        completion()
    }
    
    
}

extension EventsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.search(searchText: searchText)
            tableView.reloadData()
        } else {
            reloadData()
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reloadData()
    }
    
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Event"
        searchController.searchBar.autocapitalizationType = .allCharacters
        navigationItem.searchController = searchController
    }
}
