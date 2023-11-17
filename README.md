# Shadows Unseen
An occult detective game

## Description
Shadows Unseen is a game about a detective in an urban-fantasy setting resembling the United States just before the Great Depression. The player will investigate crimes and solve mysteries as a private eye, and will have to deal with the supernatural as well as the mundane.

## Gameplay
The PC goes around *observing scenes*, *talking to people* and *collecting facts*. Facts are automatically pinned to the string board when they are discovered. The player then *draws connections* between facts on the string board to make a case. Each case has a set of end-state string board graphs. If the player's string board matches one of the end-state graphs, the case is solved. Some cases have a time limit or some other lose condition. Cases frequently have multiple rewards in the form of items, contacts, or other benefits tied to the end-state graphs.

### Interfaces
- String board: A board of strings and pins that the player can use to connect facts and take notes.
- Dialogue: A dialogue system that allows the player to ask questions and make accusations. Facts are pinned to the string board automatically when they are discovered.
- Scene: The player can observe scenes to discover facts. Contacts are also present in scenes, and can be talked to to discover facts.

### Actions
- Observing: Classic point-and-click adventure scene. Click on things to learn about them, use items to interact.
- Talking: Dialogue system. Ask questions about the case, make accusations, etc.
- Collecting: Collect facts about the case. Facts are automatically pinned to the string board when uncovered via observation or dialogue.
- Connecting: Connect facts on the string board to make a case.

### Objects
- Contact: A person who can be talked to to discover facts.
- Item: An object that can be used to observe scenes in different ways.
- Fact: A piece of information about the case. Facts are automatically pinned to the string board when discovered.
- Case: A set of facts that are connected to each other. Cases have a set of end-state string board graphs. If the player's string board matches one of the end-state graphs, the case is solved. Some cases have a time limit or some other lose condition. Cases frequently have multiple rewards in the form of items, contacts, or other benefits tied to the end-state graphs.

## Technology
- Dialogic: Godot plugin for dialogue scenes

### Cases
Rather than working a single case at a time, the player will be able to work on multiple cases simultaneously. This will allow the player to switch between cases if they get stuck on one, and will allow the player to make connections between cases.
This will also allow the player to work on cases that are not directly related to the main plot, which will allow the player to explore the world and learn more about the setting.
Certain events in cases need to be coordinated with the main timeline, so the player will not be able to work on cases indefinitely.

The throughline of each case is some kind of Fae prince (the king in yellow) preparing to take over the city. The prince is able to grant inspiration to artists and writers, as well as enthrall and control people. The prince is also able to create illusions and manipulate shadows. They plan to enter the world through a portal created during a solar eclipse, and will use the portal to bring an army of Fae into the world.

[The King in Yellow](https://en.wikipedia.org/wiki/The_King_in_Yellow)

-- The lyrics of the song sung by the ghost lamp in Nightmare at the Opera are from Cassilda's Song, from scene 2 of the play

### Contacts
One of the potential side rewards for cases is the ability to gain a contact. Contacts can be used to gain information or items, or to gain access to restricted areas. Usually this information would be accessible through other means, but the contact will provide it more quickly or easily.

#### Example Contacts
- Police officer (New Moon Shine)
- Coroner (The Bard)
- Journalist (Yellow Journalism)
- Gangster (New Moon Shine)
- Bartender (New Moon Shine)
- Librarian / Archivist (A Gallant Mask)
- Aristocrat (Nightmare at the Opera)