//
//  DisplayVC.swift
//  SnacTrak
//
//  Created by Brittany Ryan on 2017-04-03.
//  Copyright © 2017 TeamBEAR. All rights reserved.
//

import UIKit
import CorePlot

class DisplayVC: UIViewController {

    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    var selectedGoal: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tint back button red
        self.navigationController?.navigationBar.tintColor = UIColor.red;
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initPlot()
    }
    
    func initPlot() {
        configureHostView()
        configureGraph()
        configureChart()
        configureLegend()
    }
    
    func configureHostView() {
        hostView.allowPinchScaling = false
    }
    
    func configureGraph() {
        // 1 - Create and configure the graph
        let graph = CPTXYGraph(frame: hostView.bounds)
        hostView.hostedGraph = graph
        graph.paddingLeft = 0.0
        graph.paddingTop = 0.0
        graph.paddingRight = 0.0
        graph.paddingBottom = 0.0
        graph.axisSet = nil
        
        // 2 - Create text style
        let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.red()
        textStyle.fontName = "HelveticaNeue-Bold"
        textStyle.fontSize = 17.0
        textStyle.textAlignment = .center
        
        // 3 - Set graph title and text style
        graph.title = ""
        graph.titleTextStyle = textStyle
        graph.titlePlotAreaFrameAnchor = CPTRectAnchor.top
    }
    
    func configureChart() {
        // 1 - Get a reference to the graph
        let graph = hostView.hostedGraph!
        
        // 2 - Create the chart
        let pieChart = CPTPieChart()
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.pieRadius = (min(hostView.bounds.size.width, hostView.bounds.size.height) * 0.7) / 2
        pieChart.identifier = NSString(string: graph.title!)
        pieChart.startAngle = CGFloat(M_PI_4)
        pieChart.sliceDirection = .clockwise
        pieChart.labelOffset = -0.6 * pieChart.pieRadius
        
        // 3 - Configure border style
        let borderStyle = CPTMutableLineStyle()
        borderStyle.lineColor = CPTColor.white()
        borderStyle.lineWidth = 2.0
        pieChart.borderLineStyle = borderStyle
        
        // 4 - Configure text style
        let textStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.white()
        textStyle.textAlignment = .center
        pieChart.labelTextStyle = textStyle
        
        // 5 - Add chart to graph
        graph.add(pieChart)
    }
    
    func configureLegend() {
        // 1 - Get graph instance
        guard let graph = hostView.hostedGraph else { return }
        
        // 2 - Create legend
        let theLegend = CPTLegend(graph: graph)
        
        // 3 - Configure legend
        theLegend.numberOfColumns = 1
        theLegend.fill = CPTFill(color: CPTColor.white())
        let textStyle = CPTMutableTextStyle()
        textStyle.fontSize = 18
        theLegend.textStyle = textStyle
        
        // 4 - Add legend to graph
        graph.legend = theLegend
        if view.bounds.width > view.bounds.height {
            graph.legendAnchor = .right
            graph.legendDisplacement = CGPoint(x: -20, y: 0.0)
            
        } else {
            graph.legendAnchor = .bottomRight
            graph.legendDisplacement = CGPoint(x: -8.0, y: 8.0)
        }
    }
    
}

extension DisplayVC: CPTPieChartDataSource, CPTPieChartDelegate {
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return 2
    }
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        //let symbol = symbols[Int(idx)]
        //let currencyRate = rate.rates[symbol.name]!.floatValue
        //return 1.0 / currencyRate
        switch idx {
        case 0:   return (goalArray[selectedGoal].amount - goalArray[selectedGoal].progress)/goalArray[selectedGoal].amount * 100
        case 1:   return (goalArray[selectedGoal].progress)/goalArray[selectedGoal].amount * 100
        default:  return nil
        }
    }
    
    func dataLabel(for plot: CPTPlot, record idx: UInt) -> CPTLayer? {
        
        switch idx {
        case 0:
            let layer = CPTTextLayer(text: String(format: "%.0f", (goalArray[selectedGoal].amount - goalArray[selectedGoal].progress)/goalArray[selectedGoal].amount * 100))
            layer.textStyle = plot.labelTextStyle
            return layer
        case 1:
            let layer = CPTTextLayer(text: String(format: "%.0f", (goalArray[selectedGoal].progress)/goalArray[selectedGoal].amount * 100))
            layer.textStyle = plot.labelTextStyle
            return layer
        default:
            return nil
        }

    }
    
    func sliceFill(for pieChart: CPTPieChart, record idx: UInt) -> CPTFill? {
        switch idx {
        case 0:   return CPTFill(color: CPTColor.lightGray())
        case 1:   return CPTFill(color: CPTColor.red())
        default:  return nil
        }
    }
    
    func legendTitle(for pieChart: CPTPieChart, record idx: UInt) -> String? {
        switch idx {
        case 0:   return "To Be Completed"
        case 1:   return "Completed"
        default:  return nil
        }
    }  
}
