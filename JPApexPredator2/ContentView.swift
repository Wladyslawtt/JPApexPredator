//
//  ContentView.swift
//  JPApexPredator2
//
//  Created by Vladyslav Tarabunin on 23/05/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var predators = Predators()
    
    @State var searchText = ""//מוסיף שורת חיפוש
    @State var alphabetical = false //הוספת מיון עפ שם לכפתור
    @State var currentSelection = APType.all //הוספת מיון עפ סוג לתפריט
    @State private var isNavigationBarHidden = false// New state to toggle navigation bar
    
    //פקודה לחיפוש דינוזאורים ממסמך אפקספרדטור ופרדטורס
    //הוא יחפש את הדינוזאור לפי שם בשורת חיפוש
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection) //מוסיף מיון סוג
        predators.sort(by: alphabetical) //מוסיף מיון שם
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
                List(filteredDinos) { predator in
                    NavigationLink{//קישור ניווט יעני חץ למידע
                        PredatorDetail(predator: predator, position:.camera(MapCamera(
                            centerCoordinate: predator.location,
                            distance: 30000
                            
                        ))
                        )
                    }label: {
                        // מציג דינוזאור אחד אחד: תמונה + שם + פרטים
                        HStack{
                            //Dinosaur image
                            //השורות האלו מתאימים את השם לתמונה על  ידי הקוד באפקספרדטור
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                                .shadow(color: .white,radius: 1)
                            
                            
                            VStack(alignment: .leading){//מישר את השם
                                //Dinosaur name
                                Text(predator.name)
                                    .fontWeight(.bold)
                                //Type
                                Text(predator.type.rawValue.capitalized)//רואו וואליו משמש כדי לגשת לערך הגולמי  של ערך במבנה נתונים של אנום כאשר האנום מוגדר עם סוג נתונים גולמי כמו סטרינג אינט
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal,13)
                                    .padding(.vertical,5)
                                    .background(predator.type.background)//צובע את סוג הדינוזאור
                                    .clipShape(.capsule)
                            }
                        }
                    }
                }
                
                .listStyle(.plain)
            .navigationTitle("Apex Predators")//כותרת גלילה
            .searchable(text: $searchText)//שורת חיפוש
            .autocorrectionDisabled()//מבטל תיקון אוטומטי
            .animation(.default, value: searchText)//שם אנימציה על שורת חיפוש
            .toolbar { //מוסיף כפתור במקרה שלנו לסינון
                ToolbarItem(placement: .topBarLeading) {
                    Button {// כפתור סינון
                        withAnimation{
                            alphabetical.toggle()
                        }
                    } label: {
//                        if alphabetical {
//                            Image(systemName: "film") //תמונת הכפתור
//                        } else {
//                            Image(systemName: "textformat")//תמונת הכפתור
//                        }
                        
                        Image(systemName: alphabetical ? "film" : "textformat") //גירסה מקוצרת של הקוד איף מלמעלה
                            .symbolEffect(.bounce, value: alphabetical)// אנימציה ללחיצה
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{ // תפריט סינון
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .preferredColorScheme(.dark)
            .navigationBarHidden(isNavigationBarHidden)
        }
    }
}
#Preview {
    ContentView()
}
