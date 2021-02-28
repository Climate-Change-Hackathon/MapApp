//
//  Extensions.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import CoreLocation
import Foundation
import UIKit

extension CLPlacemark {
  var abbreviation: String {
    if let name = self.name {
      return name
    }

    if let interestingPlace = areasOfInterest?.first {
      return interestingPlace
    }

    return [subThoroughfare, thoroughfare].compactMap { $0 }.joined(separator: " ")
  }
}
extension TimeInterval {
  var formatted: String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.hour, .minute]

    return formatter.string(from: self) ?? ""
  }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
