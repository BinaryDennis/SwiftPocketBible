extension Double {

    /// Rounds the double to given number of decimals
    func rounded(toDecimals decimals:Int) -> Double {
        let divisor = pow(10.0, Double(decimals))
        return (self * divisor).rounded() / divisor
    }
}
