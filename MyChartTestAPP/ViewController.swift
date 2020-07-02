//
//  ViewController.swift
//  MyChartTestAPP
//
//  Created by Maochun Sun on 2020/5/28.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit

import SwiftCharts

class ViewController: UIViewController {
    
    lazy var connectButton:  UIButton = {
        
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        

        btn.setTitle("BarChart", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(showBarChart), for: .touchUpInside)
        
        
        self.view.addSubview(btn)
        
        
        NSLayoutConstraint.activate([
            
           
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
        
        return btn
    }()
    
  
    
    lazy var charScrollView : UIScrollView = {
        let chartWidth:CGFloat = 1000
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
         
        scrollView.contentSize = CGSize(width: chartWidth, height: 250)
        //scrollView.backgroundColor = .yellow
         
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            
            
        ])
        
        return scrollView
    }()
    
    fileprivate var chart: Chart?

    fileprivate let dirSelectorHeight: CGFloat = 50
    
    
    fileprivate func barsChart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Arial", size: 15)!)
        
        let groupsData: [(title: String, [(min: Double, max: Double)])] = [
            ("A", [
                (0, 40),
                (0, 50),
                (0, 35)
                ]),
            ("B", [
                (0, 20),
                (0, 30),
                (0, 25)
                ]),
            ("C", [
                (0, 30),
                (0, 50),
                (0, 5)
                ]),
            ("D", [
                (0, 55),
                (0, 30),
                (0, 25)
                ]),
            ("A", [
                (0, 40),
                (0, 50),
                (0, 35)
                ]),
            ("B", [
                (0, 20),
                (0, 30),
                (0, 25)
                ]),
            ("C", [
                (0, 30),
                (0, 50),
                (0, 5)
                ]),
            ("D", [
                (0, 55),
                (0, 30),
                (0, 25)
                ]),
            ("A", [
                (0, 40),
                (0, 50),
                (0, 35)
                ]),
            ("B", [
                (0, 20),
                (0, 30),
                (0, 25)
                ]),
            ("C", [
                (0, 30),
                (0, 50),
                (0, 5)
                ]),
            ("D", [
                (0, 55),
                (0, 30),
                (0, 25)
                ]),
            ("A", [
                (0, 40),
                (0, 50),
                (0, 35)
                ]),
            ("B", [
                (0, 20),
                (0, 30),
                (0, 25)
                ]),
            ("C", [
                (0, 30),
                (0, 50),
                (0, 5)
                ]),
            ("D", [
                (0, 55),
                (0, 30),
                (0, 25)
                ])
        ]
        
        let groupColors = [UIColor.red.withAlphaComponent(0.6), UIColor.blue.withAlphaComponent(0.6), UIColor.green.withAlphaComponent(0.6)]
        
        let groups: [ChartPointsBarGroup] = groupsData.enumerated().map {index, entry in
            let constant = ChartAxisValueDouble(index)
            let bars = entry.1.enumerated().map {index, tuple in
                ChartBarModel(constant: constant, axisValue1: ChartAxisValueDouble(tuple.min), axisValue2: ChartAxisValueDouble(tuple.max), bgColor: groupColors[index])
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
        let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            stride(from: 0, through: 60, by: 5).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerated().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        //let frame = ExamplesDefaults.chartFrame(view.bounds)
        
        //let chartFrame = chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - dirSelectorHeight)
        let chartFrame = CGRect(x: 0, y: 0, width: 990, height: 240)
        
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5, selectionViewUpdater: ChartViewSelectorBrightness(selectedFactor: 0.5))
        
        let groupsLayer = ChartGroupedPlainBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, groups: groups, horizontal: horizontal, barSpacing: 2, groupSpacing: 25, settings: barViewSettings, tapHandler: { tappedGroupBar /*ChartTappedGroupBar*/ in
            
            let barPoint = horizontal ? CGPoint(x: tappedGroupBar.tappedBar.view.frame.maxX, y: tappedGroupBar.tappedBar.view.frame.midY) : CGPoint(x: tappedGroupBar.tappedBar.view.frame.midX, y: tappedGroupBar.tappedBar.view.frame.minY)
            
            guard let chart = self.chart, let chartViewPoint = tappedGroupBar.layer.contentToGlobalCoordinates(barPoint) else {return}
            
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y)
            
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.chart!.view, text: tappedGroupBar.tappedBar.model.axisValue2.description, font: ExamplesDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black, horizontal: horizontal)

            let anchor: CGPoint = {
                switch (horizontal, infoBubble.inverted(chart.view)) {
                case (true, true): return CGPoint(x: 1, y: 0.5)
                case (true, false): return CGPoint(x: 0, y: 0.5)
                case (false, true): return CGPoint(x: 0.5, y: 0)
                case (false, false): return CGPoint(x: 0.5, y: 1)
                }
            }()
            
            let animatorsSettings = ChartViewAnimatorsSettings(animInitSpringVelocity: 5)
            let animators = ChartViewAnimators(view: infoBubble, animators: ChartViewGrowAnimator(anchor: anchor), settings: animatorsSettings, invertSettings: animatorsSettings.withoutDamping(), onFinishInverts: {
                infoBubble.removeFromSuperview()
            })
            
            chart.view.addSubview(infoBubble)
            
            infoBubble.tapHandler = {
                animators.invert()
            }
            
            animators.animate()
        })
        
        let guidelinesSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: horizontal ? .x : .y, settings: guidelinesSettings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                groupsLayer
            ]
        )
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _ = self.connectButton
        
        //let _ = self.theChart
        
        //let _ = self.charScrollView
        
        //showChart(horizontal: false)
        
        /*
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )

        let frame = CGRect(x: 0, y: 70, width: 300, height: 500)
                
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
            color: UIColor.red,
            barWidth: 20
        )

        self.view.addSubview(chart.view)
        //self.chart = chart
        */
    }
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = barsChart(horizontal: horizontal)
        self.charScrollView.addSubview(chart.view)
        self.chart = chart
    }
    

    @objc func showBarChart(){
        //let vc = BarChartViewController()
        let vc = LineChartViewController()
        //let vc = PieChartViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

