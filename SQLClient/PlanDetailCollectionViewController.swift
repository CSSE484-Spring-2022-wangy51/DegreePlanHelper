//
//  PlanDetailCollectionViewController.swift
//  SQLClient
//
//  Created by Helen Wang on 5/15/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import UIKit

private let reuseIdentifier = kCourseCollectionCell


class CourseCollectionCell: UICollectionViewCell{
    var closure : (()->())?
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var checkBoxLabel: UILabel!
    
    @IBOutlet weak var iconButton: UIButton!
    @IBAction func pressedShowDetail(_ sender: Any) {
        closure!()
    }
    
    
    var isInEditingMode: Bool = false {
        didSet {
            checkBoxLabel.isHidden = !isInEditingMode
            
        }
    }

    
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkBoxLabel.text = isSelected ? "✓" : ""
            }else{
                iconButton.isHidden = !isSelected
            }
        }
    }
    
    
}

class PlanDetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var headerColor: UIColor?
    var pID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        PlanDetailDocumentManager.shared.initailize()
//        PlanDetailDocumentManager.shared.getData(planID: self.pID!) {
//            self.collectionView.reloadData()
//            print("coursetable: \(PlanDetailDocumentManager.shared.courseTable)")
//        }
//        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCourseCollectionCell)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewDidLoad()
        PlanDetailDocumentManager.shared.initailize()
        PlanDetailDocumentManager.shared.getData(planID: self.pID!) {
            self.collectionView.reloadData()
//            print("coursetable: \(PlanDetailDocumentManager.shared.courseTable)")
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CourseCollectionCell
//            print("index: \(indexPath)")
            cell.isInEditingMode = editing
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            deleteButton.isEnabled = false
        } else {
            deleteButton.isEnabled = true
        }
    }

    // 2
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
            deleteButton.isEnabled = false
        }
    }
    
    
    @IBAction func pressedDelete(_ sender: Any) {
        if let selectedCells = collectionView.indexPathsForSelectedItems {
              // 1
//              let items = selectedCells.map { $0.item }.sorted().reversed()
              // 2
            selectedCells.map { IndexPath in
                print("row \(IndexPath.row) of section \(IndexPath.section)")
            }
              collectionView.deleteItems(at: selectedCells)
              deleteButton.isEnabled = false
            
            }
        
//        let sc = collectionView.indexPathsForSelectedItems
//        let i = sc.map
        

    }
    
//    func pressedDelete() {
//        if let selectedCells = collectionView.indexPathsForSelectedItems {
//              // 1
//              let items = selectedCells.map { $0.item }.sorted().reversed()
//              // 2
//              for item in items {
//                  print("delete item: \(item)")
////                  modelData.remove(at: item)
//              }
//              // 3
//              collectionView.deleteItems(at: selectedCells)
//              deleteButton.isEnabled = false
//            }
//
//
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == kShowCourseDetailSegue){
            let dvc = segue.destination as! CourseDetailViewController
            let selectedCells = collectionView.indexPathsForSelectedItems
            selectedCells.map { IndexPath in
                print("indexPath: \(IndexPath)")
                print("row? \(IndexPath.first?.row)")
//                print("row \(IndexPath[0].row) of section \(IndexPath[0].section)")
                print("currentTable: \(PlanDetailDocumentManager.shared.courseTable)")
                print("current col: \(PlanDetailDocumentManager.shared.courseTable[IndexPath.first!.section])")
                let cN = PlanDetailDocumentManager.shared.courseTable[IndexPath.first!.section]![IndexPath.first!.row-1]
                print("give cN: \(cN)")
                dvc.courseNum = cN
            }
//            print("choose \(indexPath)")
//            let indexPaths = self.collectionView!.indexPathsForSelectedItems()
//            let indexPath = indexPaths[0] as NSIndexPath
            

        }
    }
    

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.

        let cellsAcross: CGFloat = 4
        let spaceBetweenCells: CGFloat = 0
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross

        return CGSize(width: dim, height: dim/2)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 20
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CourseCollectionCell
    
        // Configure the cell
        headerColor = cell.backgroundColor
        cell.courseNameLabel.text = String(indexPath.section) + String(indexPath.row)

        let map = PlanDetailDocumentManager.shared.yqToSecNum
        let header = map.first(where: { $1 == indexPath.section })?.key
        cell.layer.cornerRadius = 10
        if(indexPath.row == 0){
            cell.backgroundColor = UIColor(red: 179/255, green: 113/255, blue: 214/255, alpha: 1)
            cell.courseNameLabel.textColor = UIColor.white
            cell.courseNameLabel.text = header
        }else{
            cell.backgroundColor = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
////            print("courseTable: \(PlanDetailDocumentManager.shared.courseTable)")

            let cN = PlanDetailDocumentManager.shared.courseTable[indexPath.section]![indexPath.row-1]
            cell.courseNameLabel.textColor = UIColor.black
            cell.courseNameLabel.text = cN
        }
        
        cell.closure = {
            self.performSegue(withIdentifier: kShowCourseDetailSegue, sender: self)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == 0 {
//            // No insets for header in section 0
//            return UIEdgeInsets.zero
//        } else {
            // Normal insets for collection
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
//        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

