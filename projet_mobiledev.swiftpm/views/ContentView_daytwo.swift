

import SwiftUI

struct ContentView_daytwo: View {
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
                Text(schedule.activity_type)
                Text(timer)
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

