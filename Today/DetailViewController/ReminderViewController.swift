//
//  ReminderViewController.swift
//  Today
//
//  Created by Anh Tran on 3/14/23.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    private var dataSource: DataSource!
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
       
        
        switch (section, row) {
        
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        default:
            fatalError("Unexpected combination of section and row")
        }
              
       cell.tintColor = UIColor(named: "BackgroundColorListItem")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        if #available(iOS 16, *) {
           navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view conroller title")
        updateSnapshotForViewing()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            updateSnapshotForEditing()
        }
        else {
            updateSnapshotForViewing()
        }
    }
    
    func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([Row.header(""), Row.title, Row.notes, Row.date, Row.time], toSection: .view)

        dataSource.apply(snapshot)
    }
    
    func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .notes, .date])
        snapshot.appendItems([.header(Section.title.name)], toSection: .title)
        snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        snapshot.appendItems([.header(Section.date.name)], toSection: .date)


        dataSource.apply(snapshot)
    }
    
    var reminder: Reminder
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
        
    }
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    func section(for indexPath: IndexPath) -> Section? {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
