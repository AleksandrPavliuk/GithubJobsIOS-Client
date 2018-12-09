//
//  Date+Extensions.swift
//  GithubJobsIOS-Client
//
//  Created by Aleksandr Pavliuk on 12/9/18.
//  Copyright © 2018 CrystalTech. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let GitHubJobsDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        return dateFormatter
    }()

    static let UIDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
}

// MARK: RelativeTime
extension Date {

    enum TimeSign {
        case future
        case past
    }

    func toStringWithRelativeTime() -> String {

        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        let timeSign: TimeSign = now - time > 0 ? .past : .future

        let sec: Double = abs(now - time)
        let mins: Double = round(sec / 60)
        let hrs: Double = round(mins / 60)
        let dys: Double = round(hrs / 24)

        switch (sec, mins, hrs, dys) {
        case (let seconds, _, _, _) where seconds < 10: return makeJustNow(timeSign)
        case (let seconds, _, _, _) where seconds < 60: return makeRelative(seconds: seconds, timeSign: timeSign)
        case (_, let minutes, _, _) where minutes == 1: return makeRelativeMinute(timeSign)
        case (_, let minutes, _, _) where minutes < 60: return makeRelative(minutes: minutes, timeSign: timeSign)
        case (_, _, let hours, _) where hours == 1: return makeRelativeHour(timeSign)
        case (_, _, let hours, _) where hours < 24: return makeRelative(hours: hours, timeSign: timeSign)
        case (_, _, _, let days) where days == 1: return makeRelativeDay(timeSign)
        case (_, _, _, let days) where days < 28: return makeRelative(days: days, timeSign: timeSign)
        default: return DateFormatter.UIDateFormatter.string(from: self)
        }
    }
}

private extension Date {
    func makeJustNow(_ timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return "in a few seconds"
        case .past: return "just now"
        }
    }

    func makeRelative(seconds: Double, timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return String(format: "in %.f seconds", seconds)
        case .past: return String(format: "%.f seconds ago", seconds)
        }
    }

    func makeRelativeMinute(_ timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return "in 1 minute"
        case .past: return "1 minute ago"
        }
    }

    func makeRelative(minutes: Double, timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return String(format: "in %.f minutes", minutes)
        case .past: return String(format: "%.f minutes ago", minutes)
        }
    }

    func makeRelativeHour(_ timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return "next hour"
        case .past: return "last hour"
        }
    }

    func makeRelative(hours: Double, timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return String(format: "in %.f hours", hours)
        case .past: return String(format: "%.f hours ago", hours)
        }
    }

    func makeRelativeDay(_ timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return "tomorrow"
        case .past: return "yesterday"
        }
    }

    func makeRelative(days: Double, timeSign: TimeSign) -> String {
        switch timeSign {
        case .future: return String(format: "in %.f days", days)
        case .past: return String(format: "%.f days ago", days)
        }
    }
}
