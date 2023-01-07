//
//  ContentScheduleView.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/7/23.
//

import Foundation
import SwiftUI



struct ContentScheduleView: View {
    
    @State private var schedules: [Schedule] = []
    
    var body: some View {
        List(schedules, id: \.id) { schedule in
            ContentView(schedule: schedule)
        }
        .onAppear(perform: getSchedules)
    }

    func getSchedules() {
        let requestFactory = RequestFactory()
        print("getSchedules_1")
        requestFactory.getScheduleList { (error, schedules) in
            if let schedules = schedules {
                self.schedules = schedules
            }
        }
        /*requestFactory.getSpeakersList { (error, schedules) in
            if let speakers = speakers {
                self.speakers = speakers
            }
        }*/
    }
    
}
