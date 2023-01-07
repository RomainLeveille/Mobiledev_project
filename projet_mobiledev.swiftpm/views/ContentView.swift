
import SwiftUI

struct ContentView: View {
    var scheduleList: [Schedule]?
    var speakerList: [Speakers]?

    var body: some View {
        NavigationView {
            List(scheduleList ?? [], id: \.self) { schedule in
                // Trouvez l'orateur correspondant dans la liste des orateurs
                if let speaker = self.speakerList?.first(where: { $0.ID == schedule.speakerID }) {
                    // Affichez les données de l'orateur et du planning dans la cellule de la table view
                    HStack {
                        Text(speaker.name)
                        Spacer()
                        Text(schedule.date)
                    }
                } else {
                    // Si l'orateur n'a pas été trouvé, affichez un message d'erreur
                    Text("Erreur: orateur introuvable")
                }
            }
            .navigationBarTitle("Horaires")
        }
    }
}
