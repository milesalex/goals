//
//  NuxStepViewController.swift
//  Goals
//
//  Created by Nathaniel Hajian on 3/16/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import UIKit


public class NuxStepViewController: UIViewController {
    
    var tableView = TodosViewController()
    public var steps = Array<NuxStep>()
    
    var currentStep:NuxStep? //nuxstep
    
    func advanceToNextStep() {
        if (!self.steps.isEmpty) {
            self.currentStep = self.steps[0];
            self.steps.removeFirst()
        }
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // check nux
        let destinationController = segue.destinationViewController as! TodosViewController
        
        if (self.currentStep == nil) {
            self.advanceToNextStep()
        }
        destinationController.dataModel = self.currentStep?.model
        
        self.tableView = destinationController;
    }

    @IBAction func nextActionButton(sender: UIButton) {
        
        self.currentStep?.model.saveTodos()

        self.advanceToNextStep()
        if (self.currentStep?.model != nil) {
            self.tableView.dataModel = self.currentStep!.model
        } else {
            "ending NUX"
        }
    
        
        
    }

}
