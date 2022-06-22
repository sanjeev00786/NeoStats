//
//  FeedVC.swift
//  NeoStats
//
//  Created by Sanjeev Mehta on 22/06/22.
//

import UIKit
import AAInfographics

class FeedVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var lbls: [UILabel]!
    @IBOutlet var idlbls: [UILabel]!
    @IBOutlet weak var chartView: UIView!

    //MARK: - Variables
    let vm = FeedViewModel.shared
    var startDate = ""
    var endDate = ""
    var aaChartView: AAChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      callApi()
       
    }
    
    //MARK: - Set UI
    func setUI() {
        let firstCount = vm.feedModel.nearEarthObjects?.firstObject?.count
        let secondCount = vm.feedModel.nearEarthObjects?.secondObject?.count
//        let arr = [firstCount, secondCount]
//        let dates: [Double] = [0.00, 0.01]//["2022-06-20", "2022-06-21"]
        let chartViewWidth  = self.chartView.frame.size.width
              let chartViewHeight = self.chartView.frame.size.height
        aaChartView = AAChartView()
        aaChartView!.frame = CGRect(x: 0,y: 0,width: chartViewWidth - 10,height: chartViewHeight)

              self.chartView.addSubview(aaChartView!)
        let aaChartModel = AAChartModel()
                  .chartType(.waterfall)//Can be any of the chart types listed under `AAChartType`.
                  .animationType(.bounce)
                  .title("Graph")//The chart title
                  .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
                  .colorsTheme(["#fe117c","#ffc069"])
                  .series([
                      AASeriesElement()
                          .name("2022-06-20")
                          .data([firstCount!]),
                      AASeriesElement()
                          .name("2022-06-21")
                          .data([secondCount!]),
                          ])
        aaChartView!.aa_drawChartWithChartModel(aaChartModel)
    }
    
    //MARK: - Call Api
    func callApi() {
        vm.getFeedApi(vc: self, start: startDate, end: endDate) { [self] result in
            if result {
                lbls[0].text = String(format: "%.2f", vm.getFastestAsteroid().value)
                lbls[1].text = String(format: "%.2f", vm.getClosestAsteroid().value)
                lbls[2].text = String(format: "%.2f", vm.getAverageAsteroid())
                idlbls[0].text = vm.getFastestAsteroid().id
                idlbls[1].text = vm.getClosestAsteroid().id
                setUI()
            }
        }
    }
    
    //MARK: - Buttons Actions
    @IBAction func backBtnActn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
