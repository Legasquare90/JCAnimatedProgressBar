//
//  ViewController.swift
//  JCAnimatedProgressBar
//
//  Created by Jose Angel Cuadrado Mingo on 21/4/16.
//  Copyright © 2016 JC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var progressBar: JCAnimatedProgressBarView!
    
    @IBOutlet weak var filledPicker: UIPickerView!
    @IBOutlet weak var hollowPicker: UIPickerView!
    
    let pickerData = [UIColor.blackColor(), UIColor.darkGrayColor(), UIColor.grayColor(), UIColor.lightGrayColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.cyanColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.magentaColor(), UIColor.brownColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filledPicker.delegate = self
        filledPicker.dataSource = self
        hollowPicker.delegate = self
        hollowPicker.dataSource = self
        
        filledPicker.selectRow(1, inComponent: 0, animated: false)
        hollowPicker.selectRow(3, inComponent: 0, animated: false)
        
        progressBar.filledColor = UIColor.darkGrayColor()
        progressBar.hollowColor = UIColor.lightGrayColor()
        progressBar.progress = 20
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.progressBar.rotateView()
        }, completion: nil)
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    @IBAction func addImageAction(sender: UISwitch) {
        if (sender.on) {
            progressBar.progressImage = UIImage(named: "clock")!
        } else {
            progressBar.progressImage = UIImage()
        }
    }
    
    @IBAction func addRoundedCornerAction(sender: UISwitch) {
        progressBar.roundedCorner = sender.on
    }
    
    @IBAction func addProgress25(sender: AnyObject) {
        progressBar.progress += 25
    }
    
    @IBAction func addProgress5(sender: AnyObject) {
        progressBar.progress += 5
    }
    
    @IBAction func addProgress(sender: AnyObject) {
        progressBar.progress += 10
    }
    
    @IBAction func deleteProgress(sender: AnyObject) {
        progressBar.progress -= 10
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.backgroundColor = pickerData[row]
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == filledPicker) {
            progressBar.filledColor = pickerData[row]
        } else if (pickerView == hollowPicker) {
            progressBar.hollowColor = pickerData[row]
        }
    }
}
