

import SwiftUI

struct ContentView_daytwo: View {
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



struct ContentViewSchedule_daytwo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentScheduleView_daytwo()
                .environment(\.colorScheme, .dark)
                .previewLayout(.fixed(width: 300, height: 70))
            ContentScheduleView_daytwo()
                .environment(\.colorScheme, .light)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}

