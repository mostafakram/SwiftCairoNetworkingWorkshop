//
//  TimeLineTableViewController.swift
//  SwiftCairoNetworking
//
//  Created by Mostafa Akram on 10/12/18.
//  Copyright © 2018 Mostafa Akram. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
   
    enum State {
        case loading
        case error(error: String)
        case empty
        case populated
    }
    
    var state: State = .loading {
        didSet {
            updateBackground()
            self.tableView.reloadData()
        }
    }
    var timelines : TimeLines = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTimeLines()
    }
    
    
    func updateBackground() {
        switch state {
        case .loading:
            let activity = createActivity()
            tableView.backgroundView = activity
        case .populated:
            tableView.backgroundView = nil
        case .empty:
            tableView.addNoDataAvailable(with: "Sorry can't find merchants")
        case .error(let message):
            tableView.addNoDataAvailable(with: message)
        }
    }
    
    func createActivity() -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }

    
    
    func loadTimeLines() {
        state = .loading
        NetworkManager(completion: { (data, error) in
            if let error = error {
                self.state = .error(error: error.localizedDescription)
            }
            
            if let timelines = data as? TimeLines {
                // back to main thread to update UI
                if timelines.count > 0 {
                    self.timelines = timelines
                    self.state = .populated
                } else {
                        self.timelines = []
                self.state = .empty
                }
            }
        }).getTimeLines()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelines.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell", for: indexPath)
        
        cell.textLabel?.text = timelines[indexPath.row].date
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITableView {
    func  addNoDataAvailable(with text: String) {
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        noDataLabel.numberOfLines = 0
//        noDataLabel.font          = Font.myriadProRegular.withSize(14).metricied
        noDataLabel.text          = text
//        noDataLabel.textColor     = Color.lightGrey.withAlphaComponent(0.75)
        noDataLabel.textAlignment = .center
        backgroundView  = noDataLabel
    }
}
