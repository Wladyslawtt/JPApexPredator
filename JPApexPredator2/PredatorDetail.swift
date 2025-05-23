//
//  PredatorDetail.swift
//  JPApexPredator2
//
//  Created by Vladyslav Tarabunin on 23/05/2025.
//


import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    //הוספת משתנה מיקום
    @State var position: MapCameraPosition
    //מאחד אנימציות לקבוצה אחת בשם ניימספייס
    @Namespace var namespace
    
    var body: some View {
        GeometryReader{geo in
            ScrollView{ //מוסיף אפשרות לגלול
                ZStack(alignment: .bottomTrailing){
                    //Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{//קוסמטיקה לנראות
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), //אפקט מעבר צבעים
                                                   Gradient.Stop(color: .black, location: 1),
                                                  ], startPoint: .top, endPoint: .bottom)
                        }
                    //Dino Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5,height: geo.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black,radius: 7)
                        .offset(y: 20)
                         
                    
                }
                VStack(alignment: .leading){
                    //Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    //Current location
                    NavigationLink{
                        PredatorMap(position: .camera(
                            MapCamera(
                                centerCoordinate: predator.location,
                            distance: 1000,
                            heading: 250,
                            pitch: 80))
                    )//אנימציה יותר מתקדמת
                        //מעבר אנימציה התחלתי
                        //הקוד שלך גורם למעבר בין מסכים להיראות כאילו פריט ספציפי מתקרב ומתמזג אל תוך המסך הבא. שימוש מאוד יפה להוסיף חוויית משתמש חלקה ואינטואיטיבית.
                        // סורסאיידי מזהה ייחודי של הרכיב שממנו מתבצע הזום. יכול להיות כל מספר או מזהה ייחודי אחר. זה חשוב בשביל ש-סוויפט תדע מאיפה להתחיל את האנימציה.
                        //באין כאן אתה משתמש ב-ניימספייס, שהוא מנגנון שמאפשר ל-סוויפט לעקוב אחרי רכיבים במסכים שונים כדי ליצור אנימציות חלקות ביניהם. הגדרנו אותו למעלה
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    }label: {
                        Map(position: $position){
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125) // גובה קבוע מונע שינוי בגובה שגורם לקפיצה
                        //הוספת מפה לתצוגה
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing,5)
                        }
                        //אוברליי – מוסיף רכיב ויזואלי "מלמעלה" על תצוגה קיימת, מבלי לפגוע בה. למשל, אפשר להוסיף אייקון, טקסט, רקע וכו'.
                        //אליימנט – מיישר את השכבה בצד ימין של התצוגה הראשית (טריילינג = סוף, כלומר ימין בשפות שנכתבות משמאל לימין).
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom],5)
                                .padding(.trailing,8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    //זהו מקור המעבר באנימציות הסופי
                    //מאטצדטרנזיציה מגדיר את נקודת ההתחלה של האנימציה במסך הראשון (כמו "מאיפה תצא האנימציה")
                    //הוא עובד יחד עם נביגישיוןטרנזיציה למעלה שמופיע במסך הבא, כדי לדעת מה "לזום אליו".
                    //איידי – מזהה ייחודי של הרכיב. הוא חייב להיות תואם בין שני המסכים, גם במסך שמכיל את ה-מאטצדטרזיציה וגם במסך שמכיל את ה־ נביגיישוןטרנזיציה
                    //אין – כאן אתה משתמש ב־ניימספייס שהגדרנו למעלה, שמאפשר ל־סוויפט לזהות את הקשר בין רכיבים דומים (שיש להם אותו איידי) במסכים שונים.
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    //Appears In
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    //הקוד מציג רשימה של סרטים על המסך, כאשר כל שם סרט מוצג כטקסט
                    //סלפ איידי אומר לסוויפט להשתמש באיבר עצמו (כלומר, במחרוזת עצמה) כמזהה ייחודי איידי. זה עובד רק אם כל מחרוזת במערך ייחודית. זה חשוב כי סוויפט צריך לדעת לזהות כל איבר כדי לעקוב אחרי שינויים.
                    //מובי אין זה שם זמני שנותן לכל טקסט
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    //Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top,15)
                    ForEach(predator.movieScenes){ scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical,1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    //Link to web
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                    //כברירת מחדל כל הקישורים הם אופציונליים אז אנחנו מוסיפים סימן קריאה כדי להגיד להשתמש בקישור והוא אמיתי ולא אופציונלי
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width,alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)//מבטל את הכיסוי על התמונה
        }
    }
    
    #Preview {
        let predator = Predators().apexPredators[2]
        
        NavigationStack{
            PredatorDetail(predator: predator, position: .camera(
                MapCamera(
                    centerCoordinate: predator.location,
                    distance: 30000
                )))
            .preferredColorScheme(.dark)
        }
    }
