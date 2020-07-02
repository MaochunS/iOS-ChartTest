//
//  LineChartViewController.swift
//  MyChartTestAPP
//
//  Created by Maochun Sun on 2020/5/30.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    
    var reportData = [String:[String]]();
    
    lazy var chartView : LineChartView = {
        
        var chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        
        var dataEntries: [ChartDataEntry] = []
        var xValue = 1.0;
        
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let total = Double(value[0])
        
            let dataEntry = ChartDataEntry(x: xValue, y: total!)
            
            dataEntries.append(dataEntry)
           
            xValue += Double(2)
        }
        
        
        let set1 = LineChartDataSet(entries: dataEntries, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.setCircleColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        
        dataEntries.removeAll()
        xValue = 1.0;
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let done = Double(value[1])
        
            let dataEntry = BarChartDataEntry(x: xValue, y: done!)
            
            dataEntries.append(dataEntry)
           
            xValue += Double(2)
        }
        
        let set2 = LineChartDataSet(entries: dataEntries, label: "DataSet 2")
        set2.axisDependency = .right
        set2.setColor(.red)
        set2.setCircleColor(.white)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false

        
        dataEntries.removeAll()
        xValue = 1.0;
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let done = Double(value[2])
        
            let dataEntry = BarChartDataEntry(x: xValue, y: done!)
            
            dataEntries.append(dataEntry)
           
            xValue += Double(2)
        }
        
        let set3 = LineChartDataSet(entries: dataEntries, label: "DataSet 3")
        set3.axisDependency = .right
        set3.setColor(.yellow)
        set3.setCircleColor(.white)
        set3.lineWidth = 2
        set3.circleRadius = 3
        set3.fillAlpha = 65/255
        set3.fillColor = UIColor.yellow.withAlphaComponent(200/255)
        set3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set3.drawCircleHoleEnabled = false
        
        //let data = LineChartData(dataSets: [set1, set2, set3])
        let data = LineChartData(dataSets: [set1])
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 9))
        
        
        chart.data = data
        /*
        let chartWidth = 30 * CGFloat(self.reportData.count)
        if chartWidth > UIScreen.main.bounds.width{
            //let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
             
            scrollView.contentSize = CGSize(width: chartWidth, height: 400)
            //scrollView.backgroundColor = .yellow
             
            chart.translatesAutoresizingMaskIntoConstraints = false
            chart.frame = CGRect(x: 0, y: 0, width: chartWidth, height: 400)
            
            scrollView.addSubview(chart)
            self.view.addSubview(scrollView)
            
            NSLayoutConstraint.activate([
                
                scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
                scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
                
                
            ])
            
        }else{
            self.view.addSubview(chart)
            
            NSLayoutConstraint.activate([
                
                chart.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                chart.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                chart.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
                chart.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
                
            ])
        }
        */
        
        chart.setVisibleXRangeMaximum(6)
        self.view.addSubview(chart)
        
        NSLayoutConstraint.activate([
            
            chart.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            chart.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            chart.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            chart.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
            
        ])
        
        return chart
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        for i in 0..<30{
            var total = 100
            var done = 80
            if i % 3  == 0{
                total = 130
                done = 50
            }else if i % 2 == 0{
                total = 90
                done = 70
            }
             
            self.reportData["Driver\(i)"] = ["\(total)", "\(done)", "\(total-done)"];
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let _ = self.chartView
        
    }
}
