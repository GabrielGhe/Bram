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

### Logic component

### Model component

### Storage component

### Common classes

## Appendix A : User Stories

Priorities: High (must have) - `* * *`, Medium (nice to have)  - `* *`,  Low (unlikely to have) - `*`


Priority | As a ... | I want to ... | So that I can...
-------- | :-------- | :--------- | :-----------
`* * *` | user | create a new list | record mem that ‘some day’ I can store in my long term memory
`* * *` | user | delete a list | that I don't need anymore
`* * *` | user | create a mem inside a list | be reminded of it `some day`
`* * *` | user | get a list of mems to be reviewed on that day | can store those mems into my long term memory
`* * *` | user | search my list | find a mem that I'm looking for in an easier manner
`* * *` | user | edit a list | update the details of that specific list
`* * *` | user | edit a mem | update the details of that specific mem
`* *` | user | add tags to a mem | to search for that mem easier
`* *` | user | create a new mem from an old one | to make mems easier
`* *` | user | save an image to a mem | visualize the mem easier
`*` | new user | see usage instructions | refer to instructions when I forget how to use the App
`*` | user | save audio to a mem | remind myself of the mem by hearing
`*` | user | see the progress of a list | see how much I have improved
`*` | user | see the progress of a mem | see how much I have improved
`*` | user | share my list with someone else | help them learn too

{More to be added}

## Appendix B : Use Cases

(For all use cases below, the **System** is the `TaskManager` and the **Actor** is the `user`, unless specified otherwise)

#### Use case: Create new List

**MSS**

1. User is shown the main screen
2. User presses the create new list button
3. User is shown the new list screen
4. User can put in the name of the list
5. User can can put in tags
6. User can make the list public
7. User can make the list cost money
8. User presses create button to create list

Use case ends.

**Extensions**

3a. User presses cancel button

> 3a1. The screen is cancelled

4a. The name already exists

> 4a1. The user is notified that the name is already taken

6a. The user keeps the list private

> 6a1. The list is kept private

7a. The list is private

> 7a1. The list can't have a cost, because it's private

7b. The list doesn't have enough mems

> 7b1. The list doesn't have enough mems to add a cost
> 7b2. The user is told that the list needs at least 10 cards to be sold

8a. Task already exists

> 8a1. The user is notified that the task already exists

#### Use case: 

**MSS**

1. 
2. 
3. 
4. 
Use case ends.

**Extensions**

2a. 

> 2a1. 

## Appendix C : Non Functional Requirements

1. People should struggle. Example remembering "leaf / tree" vs remembering "river / b_at"
<img src="images/struggle.jpg" width="800"><br>

## Appendix D : Glossary

#####  mem

> A flash card that contains text, images and audio

#####  palace

> A list that holds mems

#####  Deadline

## Appendix E : Product Survey

### Quizlet

**Strength**<br>

1. Fast
2. Mobile and Web
3. Reads cards
4. Can Share cards

**Weakness**<br>

1. Doesn't do spaced repetition
2. Ugly interface
3. Doesn't use concepts from Talent Code
4. Can't sell cards

### Anki

**Strength**<br>

1. Uses spaced repetition
2. Fast
3. Custom cards
4. Can Share

**Weakness**<br>

1. Doesn't learn to predict how you learn
2. Doesn't suggest how you should learn better
3. Doesn't let you buy or sell decks that you've made
