//
//  ApexPredators.swift
//  JPApexPredator2
//
//  Created by Vladyslav Tarabunin on 23/05/2025.
//

//הגדרת משתנים מהקובץ גייסון
// לט משתנה קבוע
// ואר משתנה לא קבוע
// דאבל זה מספרים לא שלמים
//אינט זה מספרים שלמים
import SwiftUI
import MapKit
//מאפקיט זו חבילה של אפל שתעזור לנו בשתילת מפה באפליקציה

struct ApexPredator: Decodable , Identifiable {
    //דיקוד מפאנח את הקוד והמידע שאנו צריכים
    // זיהוי המידע שאנו צריכים באיידנטיפיי
    //מוציא את כל המידע כדי שיוכל להתאים לתמונה בקוד הבא
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene] //מתשנה שהגדרנו בשורות הבאות
    let link: String
    
    //שורה זו יוצרת מחרוזת חדשה שמתאימה לשם קובץ תמונה
    // היא לוקחת את השם, הופכת לאותיות קטנות ומוחקת רווחים כדי שיחפש כפי שרשום על התמונה בקונטנט וויו
    var image: String{
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    //שורה זו מגדירה שם מפה וסוג מפה
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //תת משתנים
    //מתאים את המידע לתמונה על פי מספר
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}
//הגדרת סוג משתנה לפרדטור
enum APType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: APType {
        self
    }
    
    //הגדרת צבע לכל משתנה
    var background: Color {
        switch self {
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black
        }
    }
    
    //הגדרת צורה לכל משתנה
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
