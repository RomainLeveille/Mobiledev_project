//
//  ContentScheduleView.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/7/23.
//

import Foundation
import SwiftUI
import Dispatch


struct ContentScheduleView: View {
    
    @State private var schedules: [Schedule] = [] // comprends les données de la table Schedule
    @State private var speakers: [Speakers] = []  // comprends les données de la table Speakers
    @State private var schedules_speakers: [Schedule_speaker] = []  // comprends les données de la table Schedule en ayant remplacé la colonne speaker(s) par les names venant de la table Speakers au lieu des id associés.
    
    var body: some View {
        
        
        List(schedules_speakers, id: \.id) { item in
            ContentView(schedule: item)
        }

        .onAppear(perform: getData)
    }

    func getData() {
        let requestFactory = RequestFactory()
        let group = DispatchGroup()
        
        
        
        group.enter()
        requestFactory.getScheduleList { (error, schedules) in
            if let schedules = schedules {
                self.schedules = schedules
            }
            group.leave()
        }
        group.enter()
        requestFactory.getSpeakersList { (error, speakers) in
            if let speakers = speakers {
                self.speakers = speakers
            }
            group.leave()
        }
        
        group.notify(queue: .main) {  // Permet de créer une nouvelle liste de dictionnaires qui contiendra les données de la table schedule + les noms des speakers (au lieu des id)
            var count = 0
            for schedule in self.schedules {
                count += 1
                print("first")
                if let speakerIDs = schedule.fields.speakers {
                    print(speakerIDs)
                    var names: [String] = []
                    for i in speakerIDs {
                        for sp in self.speakers {
                            if sp.id == i {
                                names.append(sp.fields.name)
                            }
                        }
                    }
                   
                    let newItem = ["id": String(count), "activity": schedule.fields.activity, "activity_type": schedule.fields.activity_type!, "start": schedule.fields.start, "end": schedule.fields.end, "location": schedule.fields.location, "speakers": names.joined(separator: ", ")]

                    let data = try! JSONEncoder().encode(newItem)
                    let scheduleSpeaker = try! JSONDecoder().decode(Schedule_speaker.self, from: data)

                    schedules_speakers.append(scheduleSpeaker)
                   
                }
                else {
                    
                    let newItem = ["id": String(count), "activity": schedule.fields.activity, "activity_type": schedule.fields.activity_type!, "start": schedule.fields.start, "end": schedule.fields.end, "location": schedule.fields.location, "speakers": "nil"]

                    let data = try! JSONEncoder().encode(newItem)
                    let scheduleSpeaker = try! JSONDecoder().decode(Schedule_speaker.self, from: data)

                    schedules_speakers.append(scheduleSpeaker)
                    

                }
            }
            
            // Permet de trier les dates par ordre croissant
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

            schedules_speakers.sort { (dict1, dict2) -> Bool in
                let dateString1 = dict1.start
                let dateString2 = dict2.start
                let date1 = dateFormatter.date(from: dateString1)!
                let date2 = dateFormatter.date(from: dateString2)!
                return date1 < date2
            }
        }
    }
}
