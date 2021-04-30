# Chapter 3 - Test Doubles

## Terminology
* **Dummy** - Object that does not nothing but is required for code compilation because a param list must be filled
* **Fake** - Actual working implementations but take an important short cut *(eg: in memory database)*
* **Stub** - Object that always returns fixed data
* **Mock** - Has the job of tracking that the object was called with meaningful parameters
* **Spy** - Similar to mocks but they make actual work happen

## Best Practices
 * When starting out buld the test double implementations directly into the test functions themselves
 * Add the type to the file and class/struct name *(eg: TableViewDataSourceStub)*
 * Do not do more tests than needed

 ## Dependency Injection Types

 * Constructor Injection - provide value when object is created
 * Property Injection - set property after it has been created
 * Closure Injection - pass in closure to either constructor or property
 * Factory Injection - varient of property injection where the property is designed ot create objects that get used in the type

 **Dependency Struct** single struct that contains all dependencies
 >```
 > struct Enviorment {
 >  var singleton1: Something  
 >  var singleton2: SomeOtherThing
 >  var singletop3: AThirdThing
 > }

 ## Cordinators
 `coordinator` property of view controller

 ## Mocking
 If using componentA and componentB and one is not mocked it is an integration test not a unit test

 ### Partial Mock

* Subclass an exsiting class and override the part you want to monitor
* Instead of subclassing the actual type subsclass what it takes in
* For example if it takes UIDevice as param subclass that
    >```
    > class UnpluggedDeviceMock: UIDevice {
    >   override var batteryState: BatteryState { 
    >       return .unplugged
    >   }
    >}
* Subsitute URLSession with one that makes not calls

## Test Data

Set up fake in memory persistent store by asking for NSInMemoryStoreType
>```
> let container = NSPersistentContainer(name: "User")
> let description = NSPersistentStoreDescription()
> description.type = NSInMemoryStoreType
> container.persistentStoreDescriptions = [description]

Test bundle is a bundle but it is not Main so instead use `Bundle(for: type(of:self))`

Data Retrieval Helper Method
> ```
> func data(for filename: String) -> Data? 
> let bundle = Bundle(for: type(of: self))
> guard let url = bundle.url(forResource: filename, withExtension: nil) else { return nil }
> return try? Data(contentsOf: url)