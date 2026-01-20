import Foundation

struct GameResult {
    let correctAnswers: Int
    let totalQuestions: Int
    let date: Date
    
    func isBetterThan(result: GameResult) -> Bool {
        correctAnswers > result.correctAnswers
    }
}
