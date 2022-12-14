//
//  MAPD714 F2022
//  Assignment 4
//  ToDo List App
//  Part 1 - Create the app UI
//  Group 9
//  Member: Suen, Chun Fung (Alan) 301277969
//          Sum, Chi Hung (Samuel) 300858503
//          Wong, Po Lam (Lizolet) 301258847
//
//  ToDoListViewCell.swift
//  ToDo List
//  Date: 13 Nov, 2022
//

import UIKit

protocol ToDoListViewCellDelegate: AnyObject {
    func didChangeSwitchValue(with tag: Int, value: Bool)
    func didClickedEditButton(with tag: Int)
}

class ToDoListViewCell: UITableViewCell {

    @IBOutlet weak var switchIsCompleted: UISwitch!{
        didSet {
            switchIsCompleted.thumbTintColor = .systemGray2
            switchIsCompleted.backgroundColor = .white
            switchIsCompleted.layer.cornerRadius = 16.0
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    private var tagSwitch: Int = 0
    private var tagEditButton: Int = 0
    
    weak var delegate: ToDoListViewCellDelegate?
    
    static let identifier = "ToDoListViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ToDoListViewCell", bundle: nil)
    }
    
    @IBAction func SwitchColor(_ sender: Any) {
        if switchIsCompleted.isOn {
            switchIsCompleted.thumbTintColor = .systemGray6
            switchIsCompleted.onTintColor = .systemGray2
        } else {
            switchIsCompleted.thumbTintColor = .systemGray2
            switchIsCompleted.backgroundColor = .white
            switchIsCompleted.layer.cornerRadius = 16.0
        }
    }
    // *****
    // Notify the parent view controller about the switch value changes
    // *****
    @IBAction func didChangeSwitchValue(_ sender: UISwitch) {
        delegate?.didChangeSwitchValue(with: tagSwitch, value: sender.isOn)
    }
    
    // *****
    // Notify the parent view controller about the button click event
    // *****
    @IBAction func didClickedEditButton(_ sender: UIButton) {
        delegate?.didClickedEditButton(with: tagEditButton)
    }
    
    // *****
    // Config the content of a table cell
    // *****
    func configure(with item: ToDoItem, row: Int) {
        self.tagSwitch = row
        self.tagEditButton = row
        switchIsCompleted.tag = row
        switchIsCompleted.setOn(item.isCompleted, animated: false)
        lblTitle.text = item.title
        lblDesc.text = item.desc
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
