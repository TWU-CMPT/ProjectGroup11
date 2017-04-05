//
//  DisplayVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan, Wamiq Jamal on 2017-04-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import Charts

class DisplayVC: UIViewController {
    
    @IBOutlet weak var chart: PieChartView!
    @IBOutlet weak var goalLabel: UILabel!
    
    var gdetails : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tint back button red
        self.navigationController?.navigationBar.tintColor = UIColor.red;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //animate Chart
        chart.animate(yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInCubic)
        //create Chart
        setChart()
    }
    
    //create chart
    func setChart() {
        var dataEntries: [ChartDataEntry] = []
        var amounts : [Double] = [(goalArray[gdetails].getNeed(i: gdetails))/goalArray[gdetails].amount * 100, goalArray[gdetails].progress/goalArray[gdetails].amount * 100]
        var labels : [String] = ["Goal (%)", "Progress (%)"]
        var info = ""
        for i in 0..<2
        {
            let dataEntry = PieChartDataEntry(value: amounts[i], label: labels[i])
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chart.data = pieChartData
        chart.chartDescription?.text = ""
        info = "Still Need: " + String(goalArray[gdetails].getNeed(i: gdetails)) + getUnits()
        goalLabel.text = info
        var colors: [UIColor] = []
        var color = UIColor.lightGray
        colors.append(color)
        color = UIColor.red
        colors.append(color)
        pieChartDataSet.colors = colors
        chart.legend.enabled = false
        chart.noDataText = "Goal Incorrectly Set"
    }
    
    //get goal units
    func getUnits() -> String{
        let ntName = goalArray[gdetails].nutrient
        var units = ""
        var sendtitle = ""
        if ((ntName == "Sodium") || (ntName == "Cholesterol") || (ntName == "Potassium"))
        {
            units = "mg of "
        }
        else if ((ntName == "Vitamin A") || (ntName == "Vitamin C") || (ntName == "Calcium") || (ntName == "Iron"))
        {
            units = "% of "
        }
        else
        {
            units = "g of "
        }
        sendtitle = units + ntName!
        return sendtitle
    }
    
}
