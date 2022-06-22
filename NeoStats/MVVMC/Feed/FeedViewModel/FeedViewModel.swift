//
//  FeedViewModel.swift
//  NeoStats
//
//  Created by Sanjeev Mehta on 22/06/22.
//

import UIKit

class FeedViewModel {
    
    static var shared = FeedViewModel()
    var feedModel: FeedModel!

    //MARK: - Api Calling
    func getFeedApi(vc: UIViewController,start: String, end: String, completion: @escaping(Bool) -> ()) {
        let url = URLS.BASE_URL +  "rest/v1/feed?start_date=\(start)&end_date=\(end)&detailed=false&api_key=\(DEMO_KEY)"
        ApiHelper.shareInstance.hitGetApi(view: vc, method: .get, url: url, isHeader: false) { json, err in
            print(json, err)
            if err != nil{
                vc.displayAlert(title: "Neo Stats", msg: "Something went wrong", ok: "ok")
                return
            }
            
            self.feedModel = FeedModel(json)
                completion(true)
           
        }
    }
    
    func getFastestAsteroid() -> FetchedData {
        var arr = [FetchedData]()
        for i in self.feedModel.nearEarthObjects!.firstObject! {
            for v in i.closeApproachData! {
                arr.append(FetchedData(id: i.id!, value: Double(v.relativeVelocity!.kilometersPerHour!)!))
            }
        }
        
        for i in self.feedModel.nearEarthObjects!.secondObject! {
            for v in i.closeApproachData! {
                arr.append(FetchedData(id: i.id!, value: Double(v.relativeVelocity!.kilometersPerHour!)!))
            }
        }
        var ar = [Double]()
        for i in arr {
            ar.append(i.value)
        }
        let maxValue = ar.max()!
        for v in arr {
            if maxValue == v.value {
                return FetchedData(id: v.id, value: v.value)
            }
        }
        return FetchedData(id: "", value: 0.00)
    }
    
    func getClosestAsteroid() -> FetchedData{
        var arr = [FetchedData]()
        for i in self.feedModel.nearEarthObjects!.firstObject! {
            for v in i.closeApproachData! {
                arr.append(FetchedData(id: i.id!, value: Double(v.missDistance!.kilometers!)!))
            }
        }
        
        for i in self.feedModel.nearEarthObjects!.secondObject! {
            for v in i.closeApproachData! {
                arr.append(FetchedData(id: i.id!, value: Double(v.missDistance!.kilometers!)!))
            }
        }
        var ar = [Double]()
        for i in arr {
            ar.append(i.value)
        }
        let maxValue = ar.min()!
        for v in arr {
            if maxValue == v.value {
                return FetchedData(id: v.id, value: v.value)
            }
        }
        return FetchedData(id: "", value: 0.00)
    }
    
    func getAverageAsteroid() -> Double {
        var arr = [Double]()
        for i in self.feedModel.nearEarthObjects!.firstObject! {
            arr.append(i.estimatedDiameter!.kilometers!.estimatedDiameterMax!)
        }
        
        for i in self.feedModel.nearEarthObjects!.secondObject! {
            arr.append(i.estimatedDiameter!.kilometers!.estimatedDiameterMax!)
        }
        
        let sumArray = arr.reduce(0, +)
        let avgArrayValue = sumArray / Double(arr.count)
        return avgArrayValue
    }
}

struct FetchedData {
    var id = ""
    var value = Double()
    
    init(id:String, value: Double) {
        self.id = id
        self.value = value
    }
}
