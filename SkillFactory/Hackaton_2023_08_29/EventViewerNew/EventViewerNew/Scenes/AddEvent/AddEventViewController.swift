//
//  AddEventViewController.swift
//  EventViewer
//
//  Created by Иван on 09.09.2023.
//

import UIKit

enum CreateEvent {
    static let enterID = NSLocalizedString("enterID", comment: "")
    static let enterDate = NSLocalizedString("enterDate", comment: "")
    static let enterKey = NSLocalizedString("enterKey", comment: "")
    static let EnterString = NSLocalizedString("EnterString", comment: "")
    static let EnterInt = NSLocalizedString("EnterInt", comment: "")
    static let EnterBool = NSLocalizedString("EnterBool", comment: "")
}

enum TitleAlert {
    static let titleID = NSLocalizedString("titleID", comment: "")
    static let titleDate = NSLocalizedString("titleDate", comment: "")
}
class AddEventViewController: UITableViewController {
    
    // MARK: - Outlets
    private lazy var createButtonItem = UIBarButtonItem(
        title: "Create",
        style: .plain,
        target: self,
        action: #selector(AddEventViewController.pressedCreateEvent)
    )
    
    private lazy var cancelButtonItem = UIBarButtonItem(
        title: "Cancel",
        style: .plain,
        target: self,
        action: #selector(AddEventViewController.cancelEvent)
    )
    
    // MARK: - Variables
    var onTapCell: ((Int, Int) -> Void)?
    var onReloadData: (() -> Void)?
    var eventManager: EventManager!
    var titlesSection: [String] = []
    var titlesEnterParameter: [String] = []
    
    var isShowDatePicker: Bool = false
    
    var titleEvent: String?
    var dateEvent: Date?
    var key: String?
    var strValue: String?
    var intValue: Int?
    var boolValue: Bool?
    
    
    // MARK: - LifeCycle
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventManager.capture(.createEventScreen("CREATE_NEW _EVENT"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerUI()
        addEventInit()
        tapCell()
    }
    
    // MARK: - Configere
    private func configerUI() {
        navigationItem.leftBarButtonItem = self.createButtonItem
        navigationItem.rightBarButtonItem = self.cancelButtonItem
        navigationItem.title = "Create Event"
        tableView.register(AddEventViewCell.self, forCellReuseIdentifier: AddEventViewCell.identifier)
    }
    
    
    // MARK: - Actions
    
    private func addEventInit() {
        addTitleSection()
        addTitleParameter()
    }
    
    func changeTitleEvent() -> Bool {
        if let title = titleEvent {
            if !title.isEmpty {
                return true
            }
        }
        return false
    }
    
    func createEvent() -> Event {
        let id = titleEvent ?? ""
        let date = dateEvent ?? Date()
        let parameter = parameter()
        
        print(parameter)
        return Event(id: id, date: date, parameters: parameter)
    }
    
    private func parameter() -> ParameterSet {
        
        if key != nil ||
            strValue != nil ||
            intValue != nil ||
            boolValue != nil {
            
            return ParameterSet(dictionaryLiteral: (key ?? "null", .array( [
                .string(strValue ?? "null"),
                .integer(intValue ?? 0),
                .bool(boolValue ?? false)
            ])))
        } else {
            return [:]
        }
        
    }
    
    private func addTitleSection() {
        titlesSection.append(LocalizationString.idEvent)
        titlesSection.append(LocalizationString.dateEvent)
        titlesSection.append(LocalizationString.parameterEvent)
    }
    
    private func addTitleParameter() {
        titlesEnterParameter.append(CreateEvent.enterKey)
        titlesEnterParameter.append(CreateEvent.EnterString)
        titlesEnterParameter.append(CreateEvent.EnterInt)
        titlesEnterParameter.append(CreateEvent.EnterBool)
        
    }
    
    @objc
    private func pressedCreateEvent() {
         let event = self.createEvent()
            eventManager.capture(event)
        
        dismiss(animated: true)
    }
    
    @objc
    private func cancelEvent() {
        dismiss(animated: true)
    }
    
    private func tapCell() {
        onTapCell = { [weak self] section, index in
            guard let self else { return }
            switch section {
            case 0: self.EnterID()
            case 1: self.enterDate()
            default:
                break
            }
        }
    }
    
    
    // MARK: - Additional functions
    private func EnterID() {
        showAlert(on: self, title: TitleAlert.titleID,massage: CreateEvent.enterID) { [weak self] text in
            guard let self else { return }
            self.titleEvent = text
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    private func enterDate() {
        self.isShowDatePicker = true
        self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
    
    
    func animation(cell: UITableViewCell) {
        UIView.animate(withDuration: 0.1, animations: {
            cell.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform.identity
            })
        })
    }
    
    private func showAlert(on view: UIViewController, title: String, massage: String, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.delegate = view as? any UITextFieldDelegate
            textField.autocapitalizationType = .allCharacters
            textField.keyboardType = .asciiCapable
            textField.placeholder = "Enter ..."
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let create = UIAlertAction(title: "Create", style: .default) { action in
            guard let textField = alert.textFields?.first, let saveText = textField.text else { return }
            completion(saveText)
        }

        alert.addAction(cancel)
        alert.addAction(create)
        view.present(alert, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 4
        default:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AddEventViewCell.identifier,
            for: indexPath) as? AddEventViewCell else { fatalError("DetailCell nil") }
        
        cell.selectionStyle = .none
        
        cell.textView.tag = indexPath.row
        
        cell.onKey = { [weak self] key in
            guard let self else { return }
            self.key = key
        }
        
        cell.onString = { [weak self] string in
            guard let self else { return }
            self.strValue = string
        }
        
        cell.onInt = { [weak self] int in
            guard let self else { return }
            self.intValue = int
        }
        
        cell.onBool = { [weak self] bool in
            guard let self else { return }
            self.boolValue = bool
        }
        
        cell.onDate = { [weak self] date in
            guard let self else { return }
            self.dateEvent = date
        }
        
        switch indexPath.section {
        case 0:
         
            if self.changeTitleEvent() {
                cell.titleLabel.text = self.titleEvent!
            } else {
                cell.titleLabel.text = CreateEvent.enterID
            }
            
        case 1:
            
            if self.isShowDatePicker {
                cell.dateView.isHidden = false
                cell.titleLabel.text?.removeAll()
            } else {
                cell.titleLabel.text = CreateEvent.enterDate
            }
            
        case 2:
            cell.resetConstraint()
            cell.titleLabel.text = self.titlesEnterParameter[indexPath.row]
            cell.setLowercaseLetter()
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.titlesSection[section]
        return section
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleSection = view as! UITableViewHeaderFooterView
        titleSection.textLabel?.text =  titleSection.textLabel?.text?.capitalized
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0, 1:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            animation(cell: cell)
        default:
            break
        }
       
        tableView.deselectRow(at: indexPath, animated: true)
        onTapCell?(indexPath.section, indexPath.row)
    }
}
