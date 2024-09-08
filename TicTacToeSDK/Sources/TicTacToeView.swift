import UIKit

public final class TicTacToeView: UIView {

    private var grid: [[String]] = [["", "", ""], ["", "", ""], ["", "", ""]]
    private var currentPlayer: String = "X"
    private let lineWidth: CGFloat = 4.0
    private var gameEnded: Bool = false
    private var markSize: CGFloat?
    private var colorLine: UIColor = .black
    
    init(markSize: CGFloat?) {
        self.markSize = markSize
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        drawGrid()
        drawMarks()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if gameEnded { return }

        let location = touch.location(in: self)
        let cellWidth = bounds.width / 3
        let cellHeight = bounds.height / 3

        let row = Int(location.y / cellHeight)
        let col = Int(location.x / cellWidth)

        if grid[row][col] == "" {
            grid[row][col] = currentPlayer
            if checkForWin() {
                gameEnded = true
                showToast(message: "\(currentPlayer) wins!", duration: 0.3)
                resetGame()
            } else if isDraw() {
                gameEnded = true
                showToast(message: "Draw!", duration: 0.3)
                resetGame()
            } else {
                currentPlayer = (currentPlayer == "X") ? "O" : "X"
            }
            setNeedsDisplay()
        }
    }
    
    public func resetGame() {
        grid = [["", "", ""], ["", "", ""], ["", "", ""]]
        currentPlayer = "X"
        gameEnded = false
        setNeedsDisplay()
    }
    
    public func setupFullScreenView(color: UIColor) {
        colorLine = color
    }

    private func drawGrid() {
        let path = UIBezierPath()
        let size = bounds.size

        // Вертикальные линии
        path.move(to: CGPoint(x: size.width / 3, y: 0))
        path.addLine(to: CGPoint(x: size.width / 3, y: size.height))

        path.move(to: CGPoint(x: 2 * size.width / 3, y: 0))
        path.addLine(to: CGPoint(x: 2 * size.width / 3, y: size.height))

        // Горизонтальные линии
        path.move(to: CGPoint(x: 0, y: size.height / 3))
        path.addLine(to: CGPoint(x: size.width, y: size.height / 3))

        path.move(to: CGPoint(x: 0, y: 2 * size.height / 3))
        path.addLine(to: CGPoint(x: size.width, y: 2 * size.height / 3))

        path.lineWidth = lineWidth
        colorLine.setStroke()
        path.stroke()
    }

    private func drawMarks() {
        let cellWidth = bounds.width / 3
        let cellHeight = bounds.height / 3

        for i in 0..<3 {
            for j in 0..<3 {
                let mark = grid[i][j]
                if mark != "" {
                    drawMark(mark, at: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i) * cellHeight), in: CGSize(width: cellWidth, height: cellHeight))
                }
            }
        }
    }

    private func drawMark(_ mark: String, at point: CGPoint, in size: CGSize) {
        let markRect = CGRect(origin: point, size: size).insetBy(dx: size.width * 0.2, dy: size.height * 0.2)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: markSize ?? 50),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: colorLine
        ]

        let attributedString = NSAttributedString(string: mark, attributes: attributes)
        attributedString.draw(in: markRect)
    }

    private func checkForWin() -> Bool {
        for i in 0..<3 {
            if (grid[i][0] != "" && grid[i][0] == grid[i][1] && grid[i][1] == grid[i][2]) ||
               (grid[0][i] != "" && grid[0][i] == grid[1][i] && grid[1][i] == grid[2][i]) {
                return true
            }
        }

        if (grid[0][0] != "" && grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2]) ||
           (grid[0][2] != "" && grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0]) {
            return true
        }

        return false
    }

    private func isDraw() -> Bool {
        for row in grid {
            if row.contains("") {
                return false
            }
        }
        return true
    }
}
