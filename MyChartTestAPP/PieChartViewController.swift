//
//  PieChartViewController.swift
//  MyChartTestAPP
//
//  Created by Maochun Sun on 2020/5/30.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    lazy var chartView : PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        

        let dataEntries = (0..<5).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(50) + 10),
                                     label: "data\(i)")
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "total")

        chartDataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
        let chartData = PieChartData(dataSet: chartDataSet)
        
        chart.data = chartData
        
        self.view.addSubview(chart)
        
        NSLayoutConstraint.activate([
            
            //chart.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            //chart.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            chart.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
            chart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            chart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            chart.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
            
        ])
        
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        let _ = chartView
    }
}
