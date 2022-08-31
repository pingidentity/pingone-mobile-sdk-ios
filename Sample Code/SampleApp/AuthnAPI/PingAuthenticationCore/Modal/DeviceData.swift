//
//  DeviceData.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import UIKit

struct DeviceData {
    
    var id: String?
    var name: String?
    var type: String?
    var target: String?
    var nickname: String?
    var enrollmentTime: Date?
    var applicationId: String?
    var bypassExpriation: Date?
    var bypassed: Bool?
    var pushEnabled: Bool?
    var osVersion: String?
    var applicationVersion: String?
    var usable: Bool?
    
    static func getDevices(From data: [[String: Any]]) -> [String: String]? {
        var devicesArray = [DeviceData]()

        for device in data {
            let deviceParsed = parseDevice(deviceDict: device)
            devicesArray.append(deviceParsed)
        }

        return getDevicesNames(data: devicesArray)
    }
    
    static func getDevicesNames(data: [DeviceData]) -> [String: String]? {
        var devicesNamesDict = [String: String]()

        for device in data {
            if let deviceId = device.id {
                if let deviceName = device.name {
                    devicesNamesDict[deviceId] = deviceName
                }
                
                if let deviceType = device.type, let deviceTarget = device.target {
                    devicesNamesDict[deviceId] = "\(deviceType) \(deviceTarget)"
                }
            }
        }
        return devicesNamesDict
    }
    
    private static func parseDevice(deviceDict: [String: Any]) -> DeviceData {
        let id = deviceDict[DeviceKeys.id] as? String
        let name = deviceDict[DeviceKeys.name] as? String
        let nickname = deviceDict[DeviceKeys.nickname] as? String
        let type = deviceDict[DeviceKeys.type] as? String
        let target = deviceDict[DeviceKeys.target] as? String
        let applicationId = deviceDict[DeviceKeys.applicationId] as? String
        let bypassed = deviceDict[DeviceKeys.name] as? Bool
        let pushEnabled = deviceDict[DeviceKeys.pushEnabled] as? Bool
        let osVersion = deviceDict[DeviceKeys.osVersion] as? String
        let applicationVersion = deviceDict[DeviceKeys.applicationVersion] as? String
        let usable = deviceDict[DeviceKeys.usable] as? Bool
        
        var enrollmentTime =  Date(timeIntervalSince1970: 0)
        if let enrollmentTimeIntreval = deviceDict[DeviceKeys.enrollmentTime] as? TimeInterval {
            enrollmentTime =  Date(timeIntervalSince1970: enrollmentTimeIntreval)
        }
        
        var bypassExpriation =  Date(timeIntervalSince1970: 0)
        if let bypassExpriationIntreval = deviceDict[DeviceKeys.bypassExpriation] as? TimeInterval {
            bypassExpriation =  Date(timeIntervalSince1970: bypassExpriationIntreval)
        }
        
        let device = DeviceData(id: id, name: name, type: type, target: target, nickname: nickname, enrollmentTime: enrollmentTime, applicationId: applicationId, bypassExpriation: bypassExpriation, bypassed: bypassed, pushEnabled: pushEnabled, osVersion: osVersion, applicationVersion: applicationVersion, usable: usable)
        return device
    }
}
