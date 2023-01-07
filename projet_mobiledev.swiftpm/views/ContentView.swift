
import SwiftUI

struct ContentView: View {
    let schedule: Schedule
    //let speakers: Speakers

    var body: some View {
        VStack(alignment: .leading) {
            Text(schedule.fields.activity).font(.title)
            Text(schedule.fields.location)
            Text(schedule.fields.start)
            Text(schedule.fields.end)
        }
    }
}



struct ContentViewSchedule_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentScheduleView()
                .environment(\.colorScheme, .dark)
                .previewLayout(.fixed(width: 300, height: 70))
            ContentScheduleView()
                .environment(\.colorScheme, .light)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}

 
