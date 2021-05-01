# Chapter 7 Tips
* Avoid state where possible
* Avoid signletons
* Avoid side effects
* Manage dependencies
* Measure and reduce complexity
* Constans rather than variables
* Make impossible conditions impossible
* User `Assert` to trap bad states
    * `Assert` only runs in debug mode
* Simplify exposed code
* Seperate 
* Protoype tests in playgrounds

>```
>if ProcessInfo.processInfo.environment["IS_TESTING"] == "1" {
>    print("We're in test mode")
>} else {
>    print("We're not in test mode")
>}