import Foundation

final class StatisticService {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case gamesCount
        case bestGameCorrect
        case bestGameTotal
        case bestGameDate
        case totalCorrectAnswers
        case totalQuestionsAsked
    }
    
    var totalCorrectAnswers: Int {
        get {
            storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalCorrectAnswers.rawValue)
        }
    }
    
    var totalQuestionsAsked: Int {
        get {
            storage.integer(forKey: Keys.totalQuestionsAsked.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalQuestionsAsked.rawValue)
        }
    }
}


// MARK: - Extension

extension StatisticService: StatisticServiceProtocol {
    
    var gamesCount: Int {
        get {
            let gamesCount = storage.integer(forKey: Keys.gamesCount.rawValue)
            
            return gamesCount
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correctAnswers = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            let totalQuestions = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            if let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date {
                return GameResult(correctAnswers: correctAnswers, totalQuestions: totalQuestions, date: date)
            } else {
                return GameResult(correctAnswers: correctAnswers, totalQuestions: totalQuestions, date: Date())
            }
        }
        set {
            storage.set(newValue.correctAnswers, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.totalQuestions, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        if totalQuestionsAsked == 0 {
            return 0.0
        } else {
            return (Double(totalCorrectAnswers) / Double(totalQuestionsAsked)) * 100.0
        }
    }
    func store(correct count: Int, total amount: Int) {
        let newResult = GameResult(correctAnswers: count, totalQuestions: amount, date: Date())
        
        if newResult.isBetterThan(result: bestGame) {
            bestGame = newResult
        }
        totalCorrectAnswers += count
        totalQuestionsAsked += amount
    }
    
    func updateStatistic() {
        gamesCount += 1
    }
    
}
