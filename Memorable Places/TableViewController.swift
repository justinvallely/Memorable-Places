//
//  TableViewController.swift
//  Memorable Places
//
//  Created by Justin Vallely on 5/20/15.
//  Copyright (c) 2015 JMVapps. All rights reserved.
//

import UIKit

// create an array containing dictionaries of 2 strings.
var places = [Dictionary<String,String>()]

var activePlace = -1

class TableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Load saved places list
        if NSUserDefaults.standardUserDefaults().objectForKey("places") != nil {
            
            places = NSUserDefaults.standardUserDefaults().objectForKey("places") as! [Dictionary<String,String>]
            
            if places.count == 0 {
                
                places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128"])
            }
            
        } else {
            
            // Remove the blank item created at initialization and add the Taj Mahal
            places.removeAtIndex(0)
            places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128"])
        }
        
        println(places.count)
        /*
        if places.count == 0 {
            
            //places.removeAtIndex(0)
            
            places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128"])
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return places.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        cell.textLabel?.text = places[indexPath.row]["name"]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "newPlace" {
            activePlace = -1
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Swipe left
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            // Remove item from to do list array
            places.removeAtIndex(indexPath.row)
            
            // Remove item from permanent storage
            NSUserDefaults.standardUserDefaults().setObject(places, forKey: "places")
            
            table.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
