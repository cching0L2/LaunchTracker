//
//  ViewController.swift
//  Launch_Tracker
//
//  Created by Camellia Peng on 2016-02-05.
//  Copyright © 2016 Camellia Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getInfoButton(sender: AnyObject) {
        
    }
    
    func getInto(){
        let url = NSURL(string:"https://spaceflightnow.com/launch-schedule/")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) -> Void in
            if let urlContent = data{
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let launchInfo = webContent!.componentsSeparatedByString("<div class=\"datename\"><span class=\"launchdate\">")
                //let launchVehicle = webContent!.componentsSeparatedByString("<span class=\"mission\">");
                if(launchInfo.count>1){
                    
                    let infoCollection = launchInfo[3].componentsSeparatedByString("</span>")
                    let launchDate = infoCollection[0]
                    let launchVehicle = infoCollection[1].componentsSeparatedByString("<span class=\"mission\">")[1].componentsSeparatedByString(" • ")[0]
                    let missionName = infoCollection[1].componentsSeparatedByString("<span class=\"mission\">")[1].componentsSeparatedByString(" • ")[1]
                    var launchWindow = infoCollection[3].componentsSeparatedByString("<span class=")[0].stringByReplacingOccurrencesOfString("<U>", withString: "").stringByReplacingOccurrencesOfString("</U>", withString: "")
                    launchWindow = launchWindow.substringFromIndex(launchWindow.startIndex.successor())
                    var launchSite = infoCollection[4].componentsSeparatedByString("</div>")[0]
                    launchSite = launchSite.substringFromIndex(launchWindow.startIndex.successor())
                    let launchDescription = infoCollection[4].componentsSeparatedByString("<div class=\"missdescrip\">")[1].componentsSeparatedByString("[")[0].stringByReplacingOccurrencesOfString("&#8217;", withString: "'")
                    
                    print(launchDate)
                    print(launchVehicle)
                    print(missionName)
                    print(launchWindow)
                    print(launchSite)
                    print(launchDescription)
                    
                    print("")
                }
                else{
                    print("no launch dates found");
                }
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getInto()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

