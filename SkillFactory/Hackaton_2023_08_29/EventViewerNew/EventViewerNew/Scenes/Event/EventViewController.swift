//
//  EventViewController.swift
//  EventViewer
//
//  Created by Иван on 08.09.2023.
//

import UIKit


enum KeyParameters {
    static let key = "key"
    static let stringValue = "stringValue"
    static let integerValue = "integerValue"
    static let booleanValue = "booleanValue"
    static let arrayValue = "arrayValue"
}

enum LocalizationString {
    static let idEvent = NSLocalizedString("idEvent", comment: "")
    static let dateEvent = NSLocalizedString("dateEvent", comment: "")
    static let parameterEvent = NSLocalizedString("parameterEvent", comment: "")
    static let key = NSLocalizedString("key", comment: "")
    static let string = NSLocalizedString("string", comment: "")
    static let int = NSLocalizedString("int", comment: "")
    static let bool = NSLocalizedString("bool", comment: "")
}

protocol EventProtocol: AnyObject {
    var titlesSection: [String] { get }
    var titlesParameter: [String] { get }
    var entityEvent: EntityEvent? { get }
}


struct EntityEvent {
    var id: String?
    var date: String?
    var parameter: EntityParameter?
}

struct EntityParameter {
    var key: String?
    var string: String?
    var int: String?
    var bool: String?
}

class EventViewController: UITableViewController {
    
    // MARK: - Outlets
    private lazy var deleteButtonItem = UIBarButtonItem(
        title: "Delete",
        style: .plain,
        target: self,
        action: #selector(EventViewController.deleteEvent)
    )
    
    private lazy var cancelButtonItem = UIBarButtonItem(
        title: "Cancel",
        style: .plain,
        target: self,
        action: #selector(EventViewController.cancelEvent)
    )
    
    // MARK: - Variables
    var titlesSection: [String] = []
    var titlesParameter: [String] = []
    
    var indexCell = 0
    var entityEvent: EntityEvent?
    var eventManager: EventManager!
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventManager.capture(.detailScreen("DETAIL_OF_EVENT"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerUI()
        eventInit()
    }
    
    // MARK: - Configere
    private func configerUI() {
        navigationItem.leftBarButtonItem = self.deleteButtonItem
        navigationItem.rightBarButtonItem = self.cancelButtonItem
        navigationItem.title = "Event Details"
        tableView.register(EventViewCell.self, forCellReuseIdentifier: EventViewCell.identifier)
    }
    
    
    // MARK: - Actions
    @objc
    private func deleteEvent() {
        eventManager.deleteEvent(index: indexCell)
        dismiss(animated: true)
    }
    
    @objc
    private func cancelEvent() {
        dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return self.entityEvent?.parameter != nil ? 4 : 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EventViewCell.identifier,
            for: indexPath) as? EventViewCell else { fatalError("EventCell nil") }
        
        cell.selectionStyle = .none
        
        cell.textView.tag = indexPath.row
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = self.entityEvent?.id
            
        case 1:
            cell.titleLabel.text = self.entityEvent?.date
            
        case 2:
            cell.resetConstraint()
            
            if self.entityEvent?.parameter != nil {
                cell.titleLabel.text = self.titlesParameter[indexPath.row]
                
                switch cell.textView.tag {
                case 0: cell.textView.text = self.entityEvent?.parameter?.key
                case 1: cell.textView.text = self.entityEvent?.parameter?.string
                case 2: cell.textView.text = self.entityEvent?.parameter?.int
                case 3: cell.textView.text = self.entityEvent?.parameter?.bool
                default:
                    break
                }
                
            }  else {
                
                cell.hideParameters()
                
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.titlesSection[section]
        return section
    }
}

extension EventViewController: EventProtocol{
    
    
    
    private func addTitleSection() {
        titlesSection.append(LocalizationString.idEvent)
        titlesSection.append(LocalizationString.dateEvent)
        titlesSection.append(LocalizationString.parameterEvent)
    }
    
    private func addTitleParameter() {
        titlesParameter.append(LocalizationString.key)
        titlesParameter.append(LocalizationString.string)
        titlesParameter.append(LocalizationString.int)
        titlesParameter.append(LocalizationString.bool)
        
    }
    
    private func eventInit() {
        addTitleSection()
        addTitleParameter()
        getParaneterOfEvent(index: indexCell)
    }
    
    private func getParaneterOfEvent(index: Int) {
        guard !eventManager.events.isEmpty else { return }
        
        var id: String?
        var date: String?
        var eventParameter: EntityParameter?
        
        if let idEvent = eventManager.events[index].value(forKey: KeyProperties.id) as? String {
            id = idEvent
        }
        
        if let createAt = eventManager.events[index].value(forKey: KeyProperties.createAt) as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let timeString = dateFormatter.string(from: createAt)
            date = timeString
        }
        
        
        if let parameters = eventManager.events[index].value(forKey: KeyProperties.parameters) as? Set<DBParameter> {
            
            for parameter in parameters {
                
                // getting all the event parameters
                let key = parameter.value(forKey: KeyParameters.key) as? String
                var stringValue = parameter.value(forKey: KeyParameters.stringValue) as? String
                var integerValue = parameter.value(forKey: KeyParameters.integerValue) as? Int
                var booleanValue = parameter.value(forKey: KeyParameters.booleanValue) as? Bool
                let arrayValue = parameter.value(forKey: KeyParameters.arrayValue) as? Set<DBParameter>
                
                if let parameters = arrayValue {
                    for parameter in parameters {
                        
                        if let string = parameter.value(forKey: KeyParameters.stringValue) as? String {
                            stringValue = string
                        }
                        
                        if let integer = parameter.value(forKey: KeyParameters.integerValue) as? Int {
                            if integer > 0 {
                                integerValue = integer
                            }
                        }
                        
                        if let boolean = parameter.value(forKey: KeyParameters.booleanValue) as? Bool {
                            booleanValue = boolean
                        }
                    }
                }
                
                
                // encode all parameters in JSONE format
                let encodedInt = try! JSONEncoder().encode(integerValue)
                let encodedBool = try! JSONEncoder().encode(booleanValue)

                // extracting data in String
                let jsonInt = String(data: encodedInt, encoding: .utf8)
                let jsonBool = String(data: encodedBool, encoding: .utf8)
                
                let parameter = EntityParameter(key: key, string: stringValue, int: jsonInt, bool: jsonBool)
                eventParameter = parameter
            }
        }
        
        entityEvent = EntityEvent(id: id, date: date, parameter: eventParameter)
        
    }
}
