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
    
    @State private var schedules: [Schedule] = []
    @State private var speakers: [Speakers] = []
    @State private var schedules_speakers: [Schedule_speaker] = []
    
    var body: some View {
        
        /*let scheduleSpeakers = zip(schedules, speakers).map { (schedule, speaker) in
                    (schedule: schedule, speaker: speaker)
        }
                
                // Affichez une liste de vues pour chaque objet de ce tableau
        List(scheduleSpeakers, id: \.schedule.id) { scheduleSpeaker in
                    ContentView(schedule: scheduleSpeaker.schedule, speaker: scheduleSpeaker.speaker)
        }
        */
        /*List(schedules, id: \.id) { schedule in
            ContentView(schedule: schedule)
        }*/
        List(schedules_speakers, id: \.id) { item in
            ContentView(schedule: item)
        }

        .onAppear(perform: getData)
    }

    func getData() {
        var requestFactory = RequestFactory()
        var group = DispatchGroup()
        
        group.enter()
        requestFactory.getScheduleList { (error, schedules) in
            if var schedules = schedules {
                self.schedules = schedules
            }
            group.leave()
        }
        group.enter()
        requestFactory.getSpeakersList { (error, speakers) in
            if var speakers = speakers {
                self.speakers = speakers
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
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
                    /*let newItem = Schedule_speaker(id: 1, activity: schedule.fields.activity, activity_type: schedule.fields.activity_type!, start: schedule.fields.start, end: schedule.fields.end, location: schedule.fields.location, speakers: names.joined(separator: ", "))
                    schedules_speakers.append(newItem)*/
                    
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
                    

                    
                    /*schedules_speakers.append(["id": 1, "activity": schedule.fields.activity,"activity_type": schedule.fields.activity_type, "start": schedule.fields.start, "end": schedule.fields.end, "location": schedule.fields.location])*/
                }
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

            /*schedules_speakers.sort { (dict1, dict2) -> Bool in
                let dateString1 = dict1["start"] as! String
                let dateString2 = dict2["start"] as! String
                let date1 = dateFormatter.date(from: dateString1)!
                let date2 = dateFormatter.date(from: dateString2)!
                return date1 < date2
            }*/
        }
    }
}
