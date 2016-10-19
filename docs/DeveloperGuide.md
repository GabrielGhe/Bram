# Developer Guide 

* [Design](#design)
* [Implementation](#implementation)
* [Testing](#testing)
* [Dev Ops](#dev-ops)
* [Appendix A: User Stories](#appendix-a--user-stories)
* [Appendix B: Use Cases](#appendix-b--use-cases)
* [Appendix C: Non Functional Requirements](#appendix-c--non-functional-requirements)
* [Appendix D: Glossary](#appendix-d--glossary)
* [Appendix E : Product Survey](#appendix-e--product-survey)
 

## Design

### Architecture

<img src="images/Architecture.png" width="600"><br>
The **_Architecture Diagram_** given above explains the high-level design of the App.
Given below is a quick overview of each component.

`Main` has only one class called [`MainApp`](../src/main/java/seedu/address/MainApp.java). It is responsible for,
* At app launch: Initializes the components in the correct sequence, and connect them up with each other.
* At shut down: Shuts down the components and invoke cleanup method where necessary.

[**`Commons`**](#common-classes) represents a collection of classes used by multiple other components.
Two of those classes play important roles at the architecture level.
* `EventsCentre` : This class (written using [Google's Event Bus library](https://github.com/google/guava/wiki/EventBusExplained))
  is used by components to communicate with other components using events (i.e. a form of _Event Driven_ design)
* `LogsCenter` : Used by many classes to write log messages to the App's log file.

The rest of the App consists four components.
* [**`UI`**](#ui-component) : The UI of tha App.
* [**`Logic`**](#logic-component) : The command executor.
* [**`Model`**](#model-component) : Holds the data of the App in-memory.
* [**`Storage`**](#storage-component) : Reads data from, and writes data to, the hard disk.

Each of the four components
* Defines its _API_ in an `interface` with the same name as the Component.
* Exposes its functionality using a `{Component Name}Manager` class.

For example, the `Logic` component (see the class diagram given below) defines it's API in the `Logic.java`
interface and exposes its functionality using the `LogicManager.java` class.<br>
<img src="images/LogicClassDiagram.png" width="800"><br>

The _Sequence Diagram_ below shows how the components interact for the scenario where the user issues the
command `delete 3`.

<img src="images\SDforDeletePerson.png" width="800">

>Note how the `Model` simply raises a `AddressBookChangedEvent` when the Address Book data are changed,
 instead of asking the `Storage` to save the updates to the hard disk.

The diagram below shows how the `EventsCenter` reacts to that event, which eventually results in the updates
being saved to the hard disk and the status bar of the UI being updated to reflect the 'Last Updated' time. <br>
<img src="images\SDforDeletePersonEventHandling.png" width="800">

> Note how the event is propagated through the `EventsCenter` to the `Storage` and `UI` without `Model` having
  to be coupled to either of them. This is an example of how this Event Driven approach helps us reduce direct 
  coupling between components.

The sections below give more details of each component.

### UI component

<img src="images/UiClassDiagram.png" width="800"><br>

**API** : [`Ui.java`](../src/main/java/seedu/address/ui/Ui.java)

The UI consists of a `MainWindow` that is made up of parts e.g.`CommandBox`, `ResultDisplay`, `PersonListPanel`,
`StatusBarFooter`, `BrowserPanel` etc. All these, including the `MainWindow`, inherit from the abstract `UiPart` class
and they can be loaded using the `UiPartLoader`.

The `UI` component uses JavaFx UI framework. The layout of these UI parts are defined in matching `.fxml` files
 that are in the `src/main/resources/view` folder.<br>
 For example, the layout of the [`MainWindow`](../src/main/java/seedu/address/ui/MainWindow.java) is specified in
 [`MainWindow.fxml`](../src/main/resources/view/MainWindow.fxml)

The `UI` component,
* Executes user commands using the `Logic` component.
* Binds itself to some data in the `Model` so that the UI can auto-update when data in the `Model` change.
* Responds to events raised from various parts of the App and updates the UI accordingly.

### Logic component

<img src="images/LogicClassDiagram.png" width="800"><br>

**API** : [`Logic.java`](../src/main/java/seedu/address/logic/Logic.java)

1. `Logic` uses the `Parser` class to parse the user command.
2. This results in a `Command` object which is executed by the `LogicManager`.
3. The command execution can affect the `Model` (e.g. adding a person) and/or raise events.
4. The result of the command execution is encapsulated as a `CommandResult` object which is passed back to the `Ui`.

Given below is the Sequence Diagram for interactions within the `Logic` component for the `execute("delete 1")`
 API call.<br>
<img src="images/DeletePersonSdForLogic.png" width="800"><br>

### Model component

<img src="images/ModelClassDiagram.png" width="800"><br>

**API** : [`Model.java`](../src/main/java/seedu/address/model/Model.java)

The `Model`,
* stores a `UserPref` object that represents the user's preferences.
* stores the Address Book data.
* exposes a `UnmodifiableObservableList<ReadOnlyPerson>` that can be 'observed' e.g. the UI can be bound to this list
  so that the UI automatically updates when the data in the list change.
* does not depend on any of the other three components.

### Storage component

<img src="images/StorageClassDiagram.png" width="800"><br>

**API** : [`Storage.java`](../src/main/java/seedu/address/storage/Storage.java)

The `Storage` component,
* can save `UserPref` objects in json format and read it back.
* can save the Address Book data in xml format and read it back.

### Common classes

Classes used by multiple components are in the `seedu.addressbook.commons` package.

## Implementation

### Logging

We are using `java.util.logging` package for logging. The `LogsCenter` class is used to manage the logging levels
and logging destinations.

* The logging level can be controlled using the `logLevel` setting in the configuration file
  (See [Configuration](#configuration))
* The `Logger` for a class can be obtained using `LogsCenter.getLogger(Class)` which will log messages according to
  the specified logging level
* Currently log messages are output through: `Console` and to a `.log` file.

**Logging Levels**

* `SEVERE` : Critical problem detected which may possibly cause the termination of the application
* `WARNING` : Can continue, but with caution
* `INFO` : Information showing the noteworthy actions by the App
* `FINE` : Details that is not usually noteworthy but may be useful in debugging
  e.g. print the actual list instead of just its size

### Configuration

Certain properties of the application can be controlled (e.g App name, logging level) through the configuration file 
(default: `config.json`):


## Testing

Tests can be found in the `./src/test/java` folder.

**In Eclipse**:
* To run all tests, right-click on the `src/test/java` folder and choose
  `Run as` > `JUnit Test`
* To run a subset of tests, you can right-click on a test package, test class, or a test and choose
  to run as a JUnit test.

**Using Gradle**:
* See [UsingGradle.md](UsingGradle.md) for how to run tests using Gradle.

We have two types of tests:

1. **GUI Tests** - These are _System Tests_ that test the entire App by simulating user actions on the GUI. 
   These are in the `guitests` package.
  
2. **Non-GUI Tests** - These are tests not involving the GUI. They include,
   1. _Unit tests_ targeting the lowest level methods/classes. <br>
      e.g. `seedu.address.commons.UrlUtilTest`
   2. _Integration tests_ that are checking the integration of multiple code units 
     (those code units are assumed to be working).<br>
      e.g. `seedu.address.storage.StorageManagerTest`
   3. Hybrids of unit and integration tests. These test are checking multiple code units as well as 
      how the are connected together.<br>
      e.g. `seedu.address.logic.LogicManagerTest`
  
**Headless GUI Testing** :
Thanks to the [TestFX](https://github.com/TestFX/TestFX) library we use,
 our GUI tests can be run in the _headless_ mode. 
 In the headless mode, GUI tests do not show up on the screen.
 That means the developer can do other things on the Computer while the tests are running.<br>
 See [UsingGradle.md](UsingGradle.md#running-tests) to learn how to run tests in headless mode.
 
#### Troubleshooting tests
 **Problem: Tests fail because NullPointException when AssertionError is expected**
 * Reason: Assertions are not enabled for JUnit tests. 
   This can happen if you are not using a recent Eclipse version (i.e. _Neon_ or later)
 * Solution: Enable assertions in JUnit tests as described 
   [here](http://stackoverflow.com/questions/2522897/eclipse-junit-ea-vm-option). <br>
   Delete run configurations created when you ran tests earlier.
  
## Dev Ops

### Build Automation

See [UsingGradle.md](UsingGradle.md) to learn how to use Gradle for build automation.

### Continuous Integration

We use [Travis CI](https://travis-ci.org/) to perform _Continuous Integration_ on our projects.
See [UsingTravis.md](UsingTravis.md) for more details.

### Making a Release

Here are the steps to create a new release.
 
 1. Generate a JAR file [using Gradle](UsingGradle.md#creating-the-jar-file).
 2. Tag the repo with the version number. e.g. `v0.1`
 2. [Crete a new release using GitHub](https://help.github.com/articles/creating-releases/) 
    and upload the JAR file your created.
   
### Managing Dependencies

A project often depends on third-party libraries. For example, Address Book depends on the
[Jackson library](http://wiki.fasterxml.com/JacksonHome) for XML parsing. Managing these _dependencies_
can be automated using Gradle. For example, Gradle can download the dependencies automatically, which
is better than these alternatives.<br>
a. Include those libraries in the repo (this bloats the repo size)<br>
b. Require developers to download those libraries manually (this creates extra work for developers)<br>

## Appendix A : User Stories

Priorities: High (must have) - `* * *`, Medium (nice to have)  - `* *`,  Low (unlikely to have) - `*`


Priority | As a ... | I want to ... | So that I can...
-------- | :-------- | :--------- | :-----------
`* * *` | new user | see usage instructions | refer to instructions when I forget how to use the App
`* * *` | user | add a task by specifying a task description only | record tasks that need to be done ‘some day’
`* * *` | user | find upcoming tasks | remove entries that I no longer need | decide what needs to be done soon
`* * *` | user | delete a task | get rid of tasks that I no longer care to track. 
`* * *` | user | edit a task | update the details of that specific task
`* * *` | user | search my tasks | find an item that I’m looking for in an easier manner
`* *` | user | undo the last command | go back to the previous state
`* *` | user | specify storage location | choose where to store the data
`* *` | user | mark tasks with a status | track completed and pending tasks
`* *` | user | use shorter versions of a command | type a command faster
`*` | user | tag my tasks based on priority | prioritize my goals
`*` | user | assign my tasks to a project or category | organize my tasks in an orderly manner
`*` | user | use common keyboard shortcuts | able to work more efficiently

{More to be added}

## Appendix B : Use Cases

(For all use cases below, the **System** is the `TaskManager` and the **Actor** is the `user`, unless specified otherwise)

#### Use case: Add Task

**MSS**

1. User requests to add a task
2. User types `add TASK_NAME [START_TIME] [END_TIME] [TIMELEFT]`
3. User is notified that the task got added<br>
Use case ends.

**Extensions**

2a. Task already exists

> 2a1. The user is notified that the task already exists

#### Use case: SetDeadline

**MSS**

1. User requests to set the deadline for a task
2. User types `setdeadline TASK_INDEX` with optional parameters for date or time left
3. Deadline gets added to the task with the specified index
4. User is notified that the deadline was added<br>
Use case ends.

**Extensions**

2a. Deadline parameters are invalid

> 2a1. The user is notified that the deadline parameters are invalid

#### Use case: SetEvent

**MSS**

1. User requests to set an event.
2. User types `set event EVENT_NAME TASK_INDEX` with optional parameters for start and end dates
3. User is notified that the event was set<br>
Use case ends.

**Extensions**

2a. Event name for that specific Index already exists

> 2a1. User is notified that the event was not added

#### Use case: SetComplete

**MSS**

1. User requests to set a task as completed
2. User types `setcomplete TASK_INDEX`
3. User is notified that the task was marked as completed<br>
Use case ends.

**Extensions**

2a. The task was already completed
2b. The task doesn't exist

> 2a1.The user is notified that the task was already completed
> 2b1.The user is notified that the task was not found

#### Use case: Delete

**MSS**

1. User requests to delete a task.
2. User types `delete TASK_INDEX`
3. User is notified that the task was deleted<br>
Use case ends.

**Extensions**

2a. The task doesn't exist

> 2a1.The user is notified that the task was not found

#### Use case: Find

**MSS**

1. User requests to find a task.
2. User types `find KEYWORD [MORE KEYWORDS]`
3. We display a list of tasks that match given keywords<br>
Use case ends.

**Extensions**

2a. No match found

> 2a1. We notify the user that there was no match found

#### Use case: Edit

**MSS**

1. User requests to edit a task.
2. User types `edit TASK_INDEX”`
3. We display the task with the given TASK_INDEX 
4. We copy the task in the prompt
5. The user is allowed to modify it<br>
Use case ends.

**Extensions**

2a. The task doesn’t exist

> 2a1. The user is notified that the task was not found

#### Use case: View

**MSS**

1. User requests to view a task.
2. User types `view TASK_INDEX`
3. We display the task with the given TASK_INDEX <br>
Use case ends.

**Extensions**

2a. The task doesn’t exist

> 2a1. The user is notified that the task was not found

#### Use case: List

**MSS**

1. User requests to list a task.
2. User types `list`
3. We display the tasks available for today<br>
Use case ends.

**Extensions**

2a. There are no tasks for today

> 2a1. The user is notified that there are no available tasks for today

#### Use case: ListAll

**MSS**

1. User requests to list a task.
2. User types `listall`
3. We display the tasks available<br>
Use case ends.

**Extensions**

2a. There are no tasks 

> 2a1. The user is notified that there are no available tasks

#### Use case: Undo

**MSS**

1. User requests to list a task.
2. User types `undo`
3. User is notified that the last command was undone and we display which command was undone<br>
Use case ends.

**Extensions**

2a. There is no command to undo

> 2a1. The user is notified that there is no command to undo

#### Use case: Help

**MSS**

1. User requests for help.
2. User types `help`
3. Helpful information is then displayed <br>
Use case ends.

**Extensions**

Use case ends.

#### Use case: Store

**MSS**

1. User requests to chnage the storage location.
2. User types `store FILE_LOCATION`
3. User is notified of the storage location specified has been set.<br>
Use case ends.

**Extensions**

2a. Storage location does not exist

> 2a1. The user is notified that the the storage location does not exist.

2b. Storage Location does not have enough space

> 2b1. The user is notified that the disk specified is full.

## Appendix C : Non Functional Requirements

1. Should work on any [mainstream OS](#mainstream-os) as long as it has Java `1.8.0_60` or higher installed.
2. Should be able to hold up to 1000 persons.
3. Should come with automated unit tests and open source code.
4. Should favor DOS style commands over Unix-style commands. 
5. Should be able to retrieve a given event/deadline in 1s when searching. 
6. Commands such as edit, update, delete should not take longer than 1s to execute. 
7. The user interface should be simple to use and understand. 

## Appendix D : Glossary

#####  Floating Task 

> A task without any time contraints

#####  Event

> An event is a task with a start date/time and an end date/time

#####  Deadline

> A deadline is a time contraint that can be added to a task. It defines an end time/date than a task must be completed by.

##### Mainstream OS

> Windows, Linux, Unix, OS-X

## Appendix E : Product Survey

### Google Calendar

**Strength**<br>

1. Able to create subtasks for each task and write details for each task/subtask
2. Able to create multiple lists to group related tasks together
3. Has a calendar view that allows user to view events, deadlines and tasks by day, week or month

**Weakness**<br>

1. Only able to view one list at a time, unable to view all tasks at once
2. Task GUI is narrow and feels a bit cluttered when there are many tasks in the list

### Any.do

**Strengths**<br>

1. Simple UI for creating tasks -- simply swipe down to create a new task
2. Voice dictation for adding tasks
3. Swipe gestures for marking completed tasks
4. Allows users to add notes/subtasks to a reminder
5. Can share and assign tasks/reminders to different friends/emails
6. Group tasks by different lists

**Weaknesses**<br>

1. Simple UI does not allow setting of due date/time when creating tasks
2. Basic task like having repeating tasks is a premium service to pay for $2/month
3. Limiting location based reminders is also as a premium service to pay for $2/month

### Sunrise Calendar

**Strengths**<br>

1. Simple user interface
2. Connects to multiple existing apps such as google calendar and wunderlist
3. Easy to create a new event

**Weaknesses**<br>

1. Not very easy to search for events
2. Bought by Microsoft so now it costs money
3. Doesn’t have a way to attach email, pdf or images

### Wunderlist

**Strengths**<br>

1. Allows the use of multiple sub-tasks/events for each task/event.
2. Very easy to use
3. Can sort tasks alphabetically, by date created, priority etc.
4. Ability to share tasks with others

**Weaknesses**<br>

1. Subtasks are limited to 25
2. Cannot merge task lists together
3. UI is not customizable