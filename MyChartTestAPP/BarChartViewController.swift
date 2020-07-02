//
//  BarChartViewController.swift
//  MyChartTestAPP
//
//  Created by Maochun Sun on 2020/5/28.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit
import Charts


class BarChartViewController: UIViewController {
    
    var reportData = [String:[String]]();
    
    lazy var theLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My test bar chart"
        label.textColor = .black
        self.view.addSubview(label)
        
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)

        
        NSLayoutConstraint.activate([
            
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
            
        ])
        
        return label
    }()
    
    lazy var chartView : BarChartView = {
        
        var chart = BarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        
      
        
        
        var dataEntries: [BarChartDataEntry] = []
        var xValue = 1.0;
        
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let total = Double(value[0])
        
            let dataEntry = BarChartDataEntry(x: xValue, y: total!)
            
            dataEntries.append(dataEntry)
           
            xValue += Double(2)
        }
        
        let set1 = BarChartDataSet(entries: dataEntries, label: "Total")
        set1.setColor(UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        dataEntries.removeAll()
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let done = Double(value[1])
        
            let dataEntry = BarChartDataEntry(x: xValue, y: done!)
            
            dataEntries.append(dataEntry)
           
            xValue = 0
        }
        
        let set2 = BarChartDataSet(entries: dataEntries, label: "Complete")
        set2.setColor(UIColor(red: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        dataEntries.removeAll()
        for i in 0..<reportData.count{
            let key = Array(self.reportData.keys)[i]
            let value = self.reportData[key]!
            let done = Double(value[2])
        
            let dataEntry = BarChartDataEntry(x: xValue, y: done!)
            
            dataEntries.append(dataEntry)
           
            xValue = 0
        }
        
        let set3 = BarChartDataSet(entries: dataEntries, label: "Uncomplete")
        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        
        let chartData = BarChartData(dataSets: [set1, set2, set3])
        //let chartData = BarChartData(dataSets: [set1])
        
        //let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Pressure")
        //chartDataSet.colors = [UIColor(red: 2/255, green: 0x93/255, blue: 0xcc/255, alpha: 1)]
    
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        chartData.barWidth = 0.4
        chartData.setValueFont(UIFont.systemFont(ofSize: 13))
        chartData.setValueTextColor(UIColor(red: 2/255, green: 0x93/255, blue: 0xcc/255, alpha: 1))
        chartData.groupBars(fromX: 1, groupSpace: 0.5, barSpace: 0.1)
        
    
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
    
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 2
        xAxis.labelCount = self.reportData.count
        xAxis.valueFormatter = self
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " $"
        leftAxisFormatter.positiveSuffix = " $"
        
        let leftAxis = chart.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = chart.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 8
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        
        let l = chart.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        
        //chart.xAxis.axisMaximum = 6
        
        //chart.data = setDataCount(3, range: 20)
        chart.data = chartData
        
        
        chart.setVisibleXRangeMaximum(6)
        
        /*
        let unit = chart.getBarBounds(entry: BarChartDataEntry(x: xValue, y: 100))
        let chartWidth = 30 * CGFloat(3 * self.reportData.count)
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
        
        for i in 0..<60{
            self.reportData["Driver\(i)"] = ["100", "20", "10"];
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let _ = self.chartView
        let _ = self.theLabel
    }
    
    
}

extension BarChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "Driver \(value)"
    }
}
