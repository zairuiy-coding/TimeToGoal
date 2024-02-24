/*
See LICENSE folder for this sample’s licensing information.
*/
import SwiftUI

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var lengthInHours: Int // user set total hours for the task
    var progressHours: Int // acutual hours; cummulative
    var color: Color
    var history: [History]
    var category: String


    // CodingKeys enum to match the JSON keys
    enum CodingKeys: String, CodingKey {
        case id, title, attendees, lengthInMinutes, color, history, lengthInHours,progressHours, category
    }
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, color: Color, history: [History] = [], lengthInHours: Int, progressHours: Int, category:String) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.color = color
        self.history = history
        self.lengthInHours = lengthInHours
        self.progressHours = progressHours
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            attendees = try container.decode([String].self, forKey: .attendees)
            lengthInMinutes = try container.decode(Int.self, forKey: .lengthInMinutes)
            
            // a custom decoding strategy for Color
            color = Color.black // Placeholder
            
            history = try container.decode([History].self, forKey: .history)
            
            // Decode lengthInHours if present, otherwise calculate from lengthInMinutes
            lengthInHours = try container.decodeIfPresent(Int.self, forKey: .lengthInHours) ?? lengthInMinutes / 60
            progressHours = try container.decodeIfPresent(Int.self, forKey: .progressHours) ?? 0
            category = try container.decode(String.self, forKey: .category)
        }
}


extension DailyScrum {
    static var data: [DailyScrum] {
        [
            DailyScrum(title: "根据功能修改前端", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 120, color: Color("Design"), lengthInHours: 2, progressHours: 1, category: "Work"),
            DailyScrum(title: "改写后端逻辑、实现功能", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 400, color: Color("App Dev"), lengthInHours: 4, progressHours: 2, category: "Health"),
            DailyScrum(title: "调试、打包成APP", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 500, color: Color("Web Dev"), lengthInHours: 1, progressHours:0, category: "Social")

        ]
    }
}

extension DailyScrum {
    struct Data {
        var title: String = ""
        var attendees: [String] = []
        var lengthInMinutes: Double = 5.0
        var color: Color = .random
        var lengthInHours: Double = 5.0
        var progressHours: Double = 3.0
        var category: String = ""
    }

    var data: Data {
        return Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), color: color, lengthInHours: Double(lengthInHours), progressHours: Double(progressHours), category: category)
    }

    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        color = data.color
        lengthInHours = Int(data.lengthInHours)
        progressHours = Int(data.progressHours)
        category = data.category
    }
}