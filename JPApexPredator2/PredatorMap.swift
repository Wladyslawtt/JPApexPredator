//
//  PredatorMap.swift
//  JPApexPredator2
//
//  Created by Vladyslav Tarabunin on 23/05/2025.
//


import SwiftUI
import MapKit

struct PredatorMap: View {
    //נותן גישה לכל המיקומים של הדינוזאורים
    let predators = Predators()
    
    @State var position: MapCameraPosition
    @State var satelite = false//מצב לווין
    
    var body: some View {
        Map(position: $position) {//מיבא את כל המיקומים של הדינוזאורים ומציג אותם על המפה במקום שנכתוב את כולם אחדאחד
            ForEach(predators.apexPredators){ predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        // כברירת מחדל הגדרנו למעלה שסטלייט פולס
        //סימן שאלה אומר ״אם הפעולה כן עושה....(סטלייט) אז לבצע״
        //שתי נקודות אומרות ״אם הפעולה לא עושה...(סטלייט) אז לבצע״
        
        .mapStyle(satelite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelite.toggle()
            } label: {//אם מצב לויין פועל לשנות את הכפתור לגלוב מלא אם לא אז לשנות לגלוב ריק
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground( .automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(
        MapCamera(
        centerCoordinate: Predators().apexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    )
    .preferredColorScheme(.dark)
}
