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
                let stringDebut = schedule.start
                let subStringDebut = stringDebut[stringDebut.index(stringDebut.startIndex, offsetBy: 11)..<stringDebut.index(stringDebut.startIndex, offsetBy: 16)]
                let stringFin = schedule.end
                let subStringFin = stringFin[stringFin.index(stringFin.startIndex, offsetBy: 11)..<stringFin.index(stringFin.startIndex, offsetBy: 16)]
                let timer = subStringDebut + " - " + subStringFin
                Text(schedule.activity).font(.title)
                Text("type of activity :  \(schedule.activity_type)")
                Text("room : \(schedule.location)")
                Text("Time : " + timer)
                if schedule.speakers != "nil"{
                    Text("speakers : \(schedule.speakers)")
                    //Text(speakers.joined(separator: ", "))
                }
                /*Text(speaker.fields.name)
                Text(speaker.fields.company)
                Text(speaker.fields.role)*/
            }
            

        }
    }
}
