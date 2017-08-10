//Notice that timer now has a strong reference to self and self has a strong reference to timer! 
//So make sure to invalidate the timer and set it to nil at apropriate time
//Or use a weak reference to timer

var timer: Timer?

func startTimer() {
     timer = Timer.scheduledTimer(timeInterval: 0.1,
                                  target: self,
                                  selector: #selector(doSomething),
                                  userInfo: nil,
                                  repeats: true)
}                               
                                                  
func doSomething() {
    //do something
}
                                                  
  
// ---------------------------------------------------
                                                  
//If targeting iOS version 10 or above, the block-based version of Timer.scheduledTimer can be used, which simplifies the potential strong reference cycles

var timer: Timer?

func startTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
        // do something here
    }
}

func stopTimer() {
    timer?.invalidate()
}

//Only if appropriate, make sure to stop your timer in deinit
deinit {
    stopTimer()
}
