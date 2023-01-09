//
//  ContentView_detail.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/9/23.
//

import Foundation
import SwiftUI

struct ContentView_detail: View {
    var schedule: Schedule_speaker
    //let speaker: Speakers

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                Text(schedule.activity).font(.title)
                Text(schedule.location)
                Text(schedule.start)
                Text(schedule.end)
                if let speakers = schedule.speakers {
                    Text(speakers)
                    //Text(speakers.joined(separator: ", "))
                }
                /*Text(speaker.fields.name)
                Text(speaker.fields.company)
                Text(speaker.fields.role)*/
            }
            

        }
    }
}
